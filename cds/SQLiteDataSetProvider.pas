unit SQLiteDataSetProvider;

interface

uses
  SysUtils, Classes, Provider, DB, DBClient, DSIntf, SQLite3, Contnrs, Windows;

type

  TSiagriDataPacketWriter = class;
  TDataSetToSQLiteBind = class;

  TDataSetProviderWrap = class(Provider.TBaseProvider)
  private
    FDataSet: TDataSet;
    FDataSetOpened: Boolean;
    FDSWriter: TDataPacketWriter;
  end;

  TEditMask = type string;
  TMyField = class(TComponent)
  private
    FAutoGenerateValue: TAutoRefreshFlag;
    FDataSet: TDataSet;
    FFieldName: string;
    FFields: TFields;
    FDataType: TFieldType;
    FReadOnly: Boolean;
    FFieldKind: TFieldKind;
    FAlignment: TAlignment;
    FVisible: Boolean;
    FRequired: Boolean;
    FValidating: Boolean;
    FSize: Integer;
    FOffset: Integer;
    FFieldNo: Integer;
    FDisplayWidth: Integer;
    FDisplayLabel: string;
    FEditMask: TEditMask;
    FValueBuffer: Pointer;
  end;

  TSQLiteDataSetProvider = class(TDataSetProvider)
  private
    FTempDataSetName: String;
    FDataPacketWriter: TSiagriDataPacketWriter;
    function GetTemporaryTableNameID: String;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
  end;

  TSQLiteAux = class
  public
    class function GenerateFieldsSQL(FieldDefs: TFieldDefs): String; static;  public
    class procedure CheckError(Erro: Integer);
    class procedure ExecuteSQL(const SQL: String);
    class procedure PrepareSQL(const SQL: String; var Stmt: TSQLiteStmt);
    class function GetTableName(DataSet: TDataSet): String;
    class procedure SetFieldData(FInsertStmt: TSQLiteStmt; Field: TField);
  end;

  TSiagriDataPacketWriter = class(TDataPacketWriter)
  private
    FDataSetToSQLiteBind: TDataSetToSQLiteBind;
  protected
    procedure AddColumn(const Info: TPutFieldInfo); override;
    procedure AddConstraints(DataSet: TDataSet); override;
    procedure AddDataSetAttributes(DataSet: TDataSet); override;
    procedure AddFieldLinks(const Info: TInfoArray); override;
    procedure AddIndexDefs(DataSet: TDataSet; const Info: TInfoArray); override;
    procedure WriteMetaData(DataSet: TDataSet; const Info: TInfoArray;
      IsReference: Boolean = False); override;
    function WriteDataSet(DataSet: TDataSet; var Info: TInfoArray;
      RecsOut: Integer): Integer; override;
  published
  public
    procedure GetDataPacket(DataSet: TDataSet; var RecsOut: Integer;
      out Data: OleVariant); override;
    constructor Create; override;
    destructor Destroy; override;
  end;

  PInsertSQLiteRec = ^TInsertSQLiteRec;
  TInsertSQLiteRec = record
    Table: String;
    DataSet: TDataSet;
    InsertStmt: TSQLiteStmt;
    FieldsDefs: TFieldDefs;
    Params: TParams;
  end;

  PDataSetToSQLiteBind = ^TDataSetToSQLiteBind;
  TDataSetToSQLiteBind = class
  private
    FBindings: TList;
    procedure GenerateInsertStmt(Rec: PInsertSQLiteRec);
  public
    function GetBinding(DataSet: TDataSet): PInsertSQLiteRec; overload;
    function GetBinding(DataSetName: String): PInsertSQLiteRec; overload;
    constructor Create;
    destructor Destroy; override;
  end;

var
  Database: TSQLiteDB;
  TemporaryTableID: Int64;
  FIgnore: PAnsiChar;
  FieldTempBuffer: TBlobByteData;

implementation

uses Dialogs, TypInfo, Math, FmtBCD;

{ TSiagriDataSetProvider }

destructor TSQLiteDataSetProvider.Destroy;
begin
  // Provider destroy FDataPacketWriter.Free;
  inherited;
end;

function TSQLiteDataSetProvider.GetTemporaryTableNameID: String;
begin
  Inc(TemporaryTableID);
  Result := 'TMP_' + IntToHex(TemporaryTableID, 2);
end;

constructor TSQLiteDataSetProvider.Create(AOwner: TComponent);
begin
  inherited;
  FTempDataSetName := GetTemporaryTableNameID;
  FDataPacketWriter := TSiagriDataPacketWriter.Create;
  TDataSetProviderWrap(Self).FDSWriter := FDataPacketWriter;
end;

{ TSQLiteAux }

class procedure TSQLiteAux.CheckError(Erro: Integer);
var
  S: PAnsiChar;
begin
  if not (Erro in [SQLITE_DONE, SQLITE_OK]) then
  begin
    S := _SQLite3_ErrMsg(Database);
    raise Exception.Create(String(UTF8String(S)));
  end;
end;

class procedure TSQLiteAux.ExecuteSQL(const SQL: String);
var
  SQL8: UTF8String;
begin
  SQL8 := UTF8String(SQL);
  CheckError(_SQLite3_Exec(Database, @SQL8[1], nil, nil, FIgnore));
end;

function GetStrDataType(DataType: TFieldType): String;
begin
  case DataType of
    ftString, ftWideString:
       Result := 'TEXT';

    ftOraBlob, ftOraClob, ftBytes, ftVarBytes, ftBlob, ftMemo, ftGraphic, ftFmtMemo:
       Result := 'BLOB';

    ftSmallint, ftInteger, ftWord, ftLargeint, ftBoolean,
    ftTime, ftDate:
      Result := 'INTEGER';

    ftDateTime, ftTimeStamp,
    ftFloat, ftCurrency, ftBCD:
      Result := 'REAL';

    else
      raise Exception.Create('Field type not supported: ' + GetEnumName(TypeInfo(TFieldType),  Ord(DataType)));
  end;
end;

class function TSQLiteAux.GenerateFieldsSQL(FieldDefs: TFieldDefs): String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to FieldDefs.Count - 1 do
    with FieldDefs[I] do
      Result := Result + Format('%s %s, ', [Name, GetStrDataType(DataType)]);
end;

class function TSQLiteAux.GetTableName(DataSet: TDataSet): String;
var
  Owner: TComponent;
begin
  Owner := DataSet.Owner;
  Result := DataSet.Name;
  while (Owner <> nil) and (Owner.Name <> '') do
  begin
    Result := Owner.Name + '_' + Result;
    Owner := Owner.Owner;
  end;
end;

class procedure TSQLiteAux.PrepareSQL(const SQL: String; var Stmt: TSQLiteStmt);
var
  SQL8: UTF8String;
begin
  SQL8 := UTF8String(SQL);
  CheckError(_SQLite3_Prepare_v2(Database, @SQL8[1], -1, Stmt, FIgnore));
end;

class procedure TSQLiteAux.SetFieldData(FInsertStmt: TSQLiteStmt;
  Field: TField);
var
  pindex, BlobSize: Integer;
  Null: Boolean;
  TimeStamp: TTimeStamp;
  bcd: String;
begin
  inherited;
  pindex := Field.FieldNo;

  if Field.DataSize > Length(FieldTempBuffer) then
    SetLength(FieldTempBuffer, Max(1024, Field.DataSize));

  if Field.IsBlob then
  begin
    BlobSize := Field.DataSet.GetBlobFieldData(Field.FieldNo, FieldTempBuffer);
    Null := BlobSize = 0;
  end
  else
    Null := not Field.DataSet.GetFieldData(Field.FieldNo, @FieldTempBuffer[0]);

  if Null then
    TSQLiteAux.CheckError(_SQLite3_Bind_null(FInsertStmt, pindex))
  else
  case Field.DataType of
    ftString, ftWideString:
    begin
       TSQLiteAux.CheckError(_SQLite3_Bind_text(FInsertStmt, pindex,
         @FieldTempBuffer[0], -1, SQLITE_TRANSIENT));
    end;

    ftOraBlob, ftOraClob, ftBytes, ftVarBytes, ftBlob, ftMemo, ftGraphic, ftFmtMemo:
       TSQLiteAux.CheckError(_SQLite3_Bind_Blob(FInsertStmt, pindex,
         @FieldTempBuffer[0], BlobSize, nil));

    ftSmallint, ftInteger, ftWord, ftBoolean:
       TSQLiteAux.CheckError(_SQLite3_Bind_Int(FInsertStmt, pindex,
         PInteger(@FieldTempBuffer[0])^));

    ftLargeint:
       TSQLiteAux.CheckError(_SQLite3_Bind_int64(FInsertStmt, pindex,
         PInt64(@FieldTempBuffer[0])^));

    ftTime:
    begin
      TSQLiteAux.CheckError(_SQLite3_Bind_Int(FInsertStmt, pindex,
         PInteger(@FieldTempBuffer[0])^));
    end;

    ftDate:
    begin
      TSQLiteAux.CheckError(_SQLite3_Bind_Int(FInsertStmt, pindex,
         PInteger(@FieldTempBuffer[0])^));
    end;

    ftDateTime, ftTimeStamp,
    ftFloat, ftCurrency:
       TSQLiteAux.CheckError(_SQLite3_Bind_Double(FInsertStmt, pindex,
         PDouble(@FieldTempBuffer[0])^));

    ftBCD, ftFMTBcd:
    begin
       bcd := BcdToStr(PBcd(@FieldTempBuffer[0])^);
       TSQLiteAux.CheckError(_SQLite3_Bind_text(FInsertStmt, pindex,
         @bcd[1], -1, SQLITE_TRANSIENT));
    end;

    else
      raise Exception.Create('Field type not supported');
  end;
end;

{ TSiagriDataPacketWriter }

procedure TSiagriDataPacketWriter.AddColumn(const Info: TPutFieldInfo);
begin
  ShowMessage('AddColumn');
end;

procedure TSiagriDataPacketWriter.AddConstraints(DataSet: TDataSet);
begin
  ShowMessage('AddConstraints');
end;

procedure TSiagriDataPacketWriter.AddDataSetAttributes(DataSet: TDataSet);
begin
  ShowMessage('AddDataSetAttributes');
end;

procedure TSiagriDataPacketWriter.AddFieldLinks(const Info: TInfoArray);
begin
  ShowMessage('AddFieldLinks');
end;

procedure TSiagriDataPacketWriter.AddIndexDefs(DataSet: TDataSet; const Info: TInfoArray);
begin
  ShowMessage('AddIndexDefs');
end;

constructor TSiagriDataPacketWriter.Create;
begin
  inherited;
  FDataSetToSQLiteBind := TDataSetToSQLiteBind.Create;
end;

destructor TSiagriDataPacketWriter.Destroy;
begin
  FDataSetToSQLiteBind.Free;
  inherited;
end;

procedure TSiagriDataPacketWriter.GetDataPacket(DataSet: TDataSet; var RecsOut: Integer; out Data: OleVariant);
var
  FPutFieldInfo: TInfoArray;
  SQL: String;
  i: Integer;
begin
  TSQLiteAux.ExecuteSQL('BEGIN TRANSACTION');
  try
    FPutFieldInfo := nil;

    while FDataSetToSQLiteBind.FBindings.Count > 0 do
    begin
      i := FDataSetToSQLiteBind.FBindings.Count - 1;
      SQL := Format('drop table %s', [PInsertSQLiteRec(FDataSetToSQLiteBind.FBindings[i]).Table]);
      TSQLiteAux.ExecuteSQL(SQL);
      FDataSetToSQLiteBind.FBindings.Delete(i);
    end;

    RecsOut := WriteDataSet(DataSet, FPutFieldInfo, RecsOut);
  finally
    TSQLiteAux.ExecuteSQL('COMMIT TRANSACTION');
  end;

  Data := Integer(@FDataSetToSQLiteBind);
end;

function TSiagriDataPacketWriter.WriteDataSet(DataSet: TDataSet; var Info: TInfoArray; RecsOut: Integer): Integer;

var
  i, count: Integer;
  Rec: PInsertSQLiteRec;
  Details: TList;
  HasDetails: Boolean;

  function OpenCloseDetails(Info: TInfoArray; ActiveState: Boolean): Boolean;
  var
    I, RecsOut: Integer;
    List: TList;
  begin
    Result := False;

    for I := 0 to Details.Count -1 do
    begin
      TDataSet(Details[i]).Active := ActiveState;

      if ActiveState then
      begin
        RecsOut := -1;
        WriteDataSet(TDataSet(Details[i]), Info, RecsOut);
      end;
    end;
  end;

begin
  Result := 0;
  if RecsOut = AllRecords then
    RecsOut := High(Integer);

  Rec := FDataSetToSQLiteBind.GetBinding(DataSet);
  Details := TList.Create;
  try
    DataSet.GetDetailDataSets(Details);
    HasDetails := Details.Count > 0;

    count := DataSet.FieldCount;

    while not DataSet.Eof do
    begin
      _SQLite3_Reset(Rec.InsertStmt);

      for i := 0 to count - 1 do
      begin
        TSQLiteAux.SetFieldData(Rec.InsertStmt, DataSet.Fields[i]);
      end;

      _SQLite3_Step(Rec.InsertStmt);

      Inc(Result);

      if HasDetails then
        OpenCloseDetails(Info, true);

      if Result < RecsOut then
      begin
        DataSet.Next;
      end;
    end;

    OpenCloseDetails(Info, False);
  finally
    Details.Free;
  end;
end;

procedure TSiagriDataPacketWriter.WriteMetaData(DataSet: TDataSet; const Info: TInfoArray; IsReference: Boolean);
begin
end;

{ TDataSetToSQLiteBind }

constructor TDataSetToSQLiteBind.Create;
begin
  inherited;
  FBindings := TList.Create;
end;

destructor TDataSetToSQLiteBind.Destroy;
var
  i: Integer;
begin
  for i := 0 to FBindings.Count - 1 do
    FreeMem(FBindings[i]);
  FBindings.Free;
  inherited;
end;

function TDataSetToSQLiteBind.GetBinding(DataSet: TDataSet): PInsertSQLiteRec;
var
  i: Integer;
  Rec: PInsertSQLiteRec;
  FieldsSQL, CreateSQL: String;
  List: TList;
  Params: TParams;
begin
  if DataSet.FieldDefs.Count = 0 then
    raise Exception.Create('No fields in dataset.');

  for i := 0 to FBindings.Count - 1 do
    if (PInsertSQLiteRec(FBindings[i]).DataSet = DataSet) then
    begin
      Result := PInsertSQLiteRec(FBindings[i]);
      Exit;
    end;

  Rec := AllocMem(sizeof(TInsertSQLiteRec));
  Rec.Table := TSQLiteAux.GetTableName(DataSet);
  Rec.DataSet := DataSet;
  Rec.FieldsDefs := TFieldDefs.Create(DataSet);
  Rec.FieldsDefs.Assign(DataSet.FieldDefs);
  Rec.InsertStmt := nil;

  FieldsSQL := TSQLiteAux.GenerateFieldsSQL(DataSet.FieldDefs);
  FieldsSQL := Copy(FieldsSQL, 1, Length(FieldsSQL) - 2);
  CreateSQL := Format('create table %s (%s)', [Rec.Table, FieldsSQL]);
  TSQLiteAux.ExecuteSQL(CreateSQL);

  Params := IProviderSupport(DataSet).PSGetParams;
  Rec.Params := Params;
  if Assigned(Params) and (Params.Count > 0) then
  begin
    CreateSQL := Format('create index idx_pars_%s on %s(', [Rec.Table, Rec.Table]);
    for i := 0 to Params.Count - 1 do
      CreateSQL := CreateSQL + Params[i].Name + ', ';
    CreateSQL := Copy(CreateSQL, 1, Length(CreateSQL)-2) + ')';
    TSQLiteAux.ExecuteSQL(CreateSQL);
  end;

  GenerateInsertStmt(Rec);

  List := TList.Create;
  try
    DataSet.GetDetailDataSets(List);
    for i := 0 to List.Count - 1 do
      Rec.FieldsDefs.Add(DataSet.Name + TDataSet(List[i]).Name, ftDataSet);
  finally
    List.Free;
  end;

  FBindings.Add(Rec);
  Result := Rec;
end;

procedure TDataSetToSQLiteBind.GenerateInsertStmt(Rec: PInsertSQLiteRec);
var
  i: Integer;
  Name, SQL, Fields: String;
begin
  Fields := '';
  for i := 0 to Rec.DataSet.FieldCount - 1 do
  begin
    Name := Rec.DataSet.Fields[i].FieldName;
    Fields := Fields + Name + ', ';
  end;
  Fields := Copy(Fields, 1, Length(Fields)-2);

  SQL := 'insert into ' + Rec.Table + '(' + Fields + ') values (' +
    StringReplace(':' + Fields, ', ', ', :', [rfReplaceAll]) + ')';

  if (Rec.InsertStmt <> nil) then
    _SQLite3_Finalize(Rec.InsertStmt);
  TSQLiteAux.PrepareSQL(SQL, Rec.InsertStmt);
end;

function TDataSetToSQLiteBind.GetBinding(DataSetName: String): PInsertSQLiteRec;
var
  i: Integer;
begin
  for i := 0 to FBindings.Count - 1 do
    if (PInsertSQLiteRec(FBindings[i]).Table = DataSetName) then
    begin
      Result := PInsertSQLiteRec(FBindings[i]);
      Exit;
    end;
  raise Exception.Create('Dataset not found.');
end;

initialization
  TemporaryTableID := 0;
  if _SQLite3_Open(':memory:', Database) <> 0 then
    raise Exception.Create('Can''t open memory database.');

finalization
  _SQLite3_Close(Database);

end.

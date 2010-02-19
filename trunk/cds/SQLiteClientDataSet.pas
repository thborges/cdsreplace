unit SQLiteClientDataSet;

interface

uses SysUtils, Classes, DB, DBClient, SQLiteDataSetProvider, SQLite3;

type

  {$IFDEF VER180}
  PByte = PAnsiChar;
  {$ENDIF}

  PRecordNode = ^TRecordNode;
  TRecordNode = record
    Id: Int64;
    BdId: Integer;
    Next: PRecordNode;
    Prior: PRecordNode;
  end;

  PRecordBuffer = ^TRecordBuffer;
  TRecordBuffer = record
    Node: PRecordNode;
    BookFlag: TBookmarkFlag;
  end;

  TSQLiteClientDataSet = class(TWideDataSet)
  private
    FDataSetProvider: TSQLiteDataSetProvider;
    FBeforeGetRecords: TRemoteEvent;
    FAfterGetRecords: TRemoteEvent;
    FParams: TParams;
    FIndexFieldNames: String;
    FSelectAllStmt: TSQLiteStmt;
    FSelectOneStmt: TSQLiteStmt;
    FRootRow: PRecordNode;
    FLastRow: PRecordNode;
    FCurrentRec: PRecordNode;
    FCurrentOpenRec: PRecordNode;
    FRecordCount: Integer;
    FCursorOpen: Boolean;
    FRecordSize: Word;
    FActualRecordId: Integer;
    FDataSetToSQLiteBind: PDataSetToSQLiteBind;
    FMasterLink: TMasterDataLink;
    function GetDataSetProvider: TSQLiteDataSetProvider;
    procedure SetDataSetProvider(const Value: TSQLiteDataSetProvider);
    procedure DoAfterGetRecords(var OwnerData: OleVariant);
    procedure DoBeforeGetRecords(var OwnerData: OleVariant);
    function DoGetRecords(Count: Integer; out RecsOut: Integer): OleVariant;
    procedure SetParams(const Value: TParams);
    procedure SetIndexFieldNames(const Value: String);
    function GetSelectOrderBy: String;
    function GetWhereClause: String;
    function Navigate(GetMode: TGetMode): TGetResult;
    procedure MasterChanged(Sender: TObject);
    procedure MasterDisabled(Sender: TObject);
  protected
    procedure DataEvent(Event: TDataEvent; Info: Integer); override;
    function AllocRecordBuffer: PByte; override;
    procedure FreeRecordBuffer(var Buffer: PByte); override;
    procedure GetBookmarkData(Buffer: PByte; Data: Pointer); override;
    function GetBookmarkFlag(Buffer: PByte): TBookmarkFlag; override;
    function GetRecord(Buffer: PByte; GetMode: TGetMode; DoCheck: Boolean): TGetResult; override;
    function GetRecordSize: Word; override;
    procedure InternalAddRecord(Buffer: Pointer; Append: Boolean); override;
    procedure InternalClose; override;
    procedure InternalDelete; override;
    procedure InternalFirst; override;
    procedure InternalGotoBookmark(Bookmark: Pointer); override;
    procedure InternalHandleException; override;
    procedure InternalInitFieldDefs; override;
    procedure InternalInitRecord(Buffer: PByte); override;
    procedure InternalLast; override;
    procedure InternalOpen; override;
    procedure InternalPost; override;
    procedure InternalSetToRecord(Buffer: PByte); override;
    function IsCursorOpen: Boolean; override;
    procedure SetBookmarkData(Buffer: PByte; Data: Pointer); override;
    procedure SetBookmarkFlag(Buffer: PByte; Value: TBookmarkFlag); override;
    procedure SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean); override;
    procedure BuildRowIdIndex;
    procedure SetParamsFromMaster(stmt: TSQLiteStmt; Master: TDataSet);
    function GetRecordCount: Integer; override;
    function OpenCurrentRecord: Boolean;
    function GetRecNo: Integer; override;
    function GetSQLiteTableName: String;
    procedure SetDataSetField(const Value: TDataSetField); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetFieldData(Field: TField; Buffer: Pointer): Boolean; override;
    function Locate(const KeyFields: string; const KeyValues: Variant;
      Options: TLocateOptions): Boolean; override;

  published
    property IndexFieldNames: String read FIndexFieldNames write SetIndexFieldNames;
    property Params: TParams read FParams write SetParams;
    property DataSetProvider: TSQLiteDataSetProvider read GetDataSetProvider write SetDataSetProvider;
    property DataSetField;
    property BeforeGetRecords: TRemoteEvent read FBeforeGetRecords write FBeforeGetRecords;
    property AfterGetRecords: TRemoteEvent read FAfterGetRecords write FAfterGetRecords;
    property BeforeOpen;
    property AfterOpen;
    property BeforeClose;
    property AfterClose;
    property BeforeInsert;
    property AfterInsert;
    property BeforeEdit;
    property AfterEdit;
    property BeforePost;
    property AfterPost;
    property BeforeCancel;
    property AfterCancel;
    property BeforeDelete;
    property AfterDelete;
    property BeforeScroll;
    property AfterScroll;
    property BeforeRefresh;
    property AfterRefresh;
    property OnCalcFields;
    property OnDeleteError;
    property OnEditError;
    property OnFilterRecord;
    property OnNewRecord;
    property OnPostError;
    property Active;
  end;

procedure Register;

implementation

uses StrUtils, Variants, Dialogs, Windows;

procedure Register;
begin
  RegisterComponents('SQLiteCds', [TSQLiteDataSetProvider]);
  RegisterComponents('SQLiteCds', [TSQLiteClientDataSet]);
end;

function AllocRecordRow(PriorRow: PRecordNode): PRecordNode;
begin
  Result := AllocMem(sizeof(TRecordNode));
  FillChar(Result^, sizeof(TRecordNode), 0);

  Result.Prior := PriorRow;
  if PriorRow <> nil then
    PriorRow.Next := Result;
end;

procedure DestroyRecordList(var First: PRecordNode);
var
  NextRec, CurrentRec: PRecordNode;
begin
  CurrentRec := First;
  while (CurrentRec <> nil) do
  begin
     NextRec := CurrentRec.Next;
     FreeMem(CurrentRec);
     CurrentRec := NextRec;
  end;
  First := nil;
end;


{ TSiagriClientDataSet }

function TSQLiteClientDataSet.AllocRecordBuffer: PByte;
var
  rsize: Word;
begin
  rsize := GetRecordSize;
  Result := AllocMem(rsize);
  FillChar(Result^, rsize, 0);
end;

procedure TSQLiteClientDataSet.FreeRecordBuffer(var Buffer: PByte);
begin
  FreeMem(Buffer);
end;

procedure TSQLiteClientDataSet.GetBookmarkData(Buffer: PByte; Data: Pointer);
begin
  inherited;

end;

function TSQLiteClientDataSet.GetBookmarkFlag(Buffer: PByte): TBookmarkFlag;
begin
  Result := PRecordBuffer(Buffer).BookFlag;
end;

function TSQLiteClientDataSet.GetDataSetProvider: TSQLiteDataSetProvider;
begin
  Result := FDataSetProvider;
end;

function TSQLiteClientDataSet.GetFieldData(Field: TField; Buffer: Pointer): Boolean;
var
  i, i64, index: Int64;
  d: Double;
  s: PAnsiChar;
  //fname: AnsiString;
begin
  Result := OpenCurrentRecord;
  //fname := UTF8String(Field.FieldName);
  index := Field.Index;
  if not Result or (Sqlite3_ColumnType(FSelectOneStmt, index) = SQLITE_NULL) then
  begin
    Result := False;
    Exit;
  end;

  case Field.DataType of
    ftString, ftWideString:
    begin
      s := Sqlite3_ColumnText(FSelectOneStmt, index);
      Move(s[0], Buffer^, Length(s)+1);
    end;

    ftSmallInt, ftInteger:
    begin
      i := Sqlite3_ColumnInt(FSelectOneStmt, index);
      Integer(Buffer^) := i;
    end;

    ftLargeint:
    begin
      i64 := Sqlite3_ColumnInt64(FSelectOneStmt, index);
      Int64(Buffer^) := i64;
    end;

    ftFloat:
    begin
      d := Sqlite3_ColumnDouble(FSelectOneStmt, index);
      Double(Buffer^) := d;
    end;

    ftDate:
    begin
      i := Sqlite3_ColumnInt(FSelectOneStmt, index);
      TDateTimeRec(Buffer^).Date := i;
    end;

    ftTime:
    begin
      i := Sqlite3_ColumnInt(FSelectOneStmt, index);
      TDateTimeRec(Buffer^).Time := i;
    end;

    else
      Result := False;
  end;
end;

function TSQLiteClientDataSet.Navigate(GetMode: TGetMode): TGetResult;
begin
  if RecordCount < 1 then
    Result := grEOF
  else
    begin
    Result:=grOK;
    case GetMode of
      gmNext:
      begin
        if FActualRecordId >= RecordCount then
          Result := grEOF
        else begin
          Inc(FActualRecordId);

          if FActualRecordId = 1 then
            FCurrentRec := FRootRow
          else
            FCurrentRec := FCurrentRec.Next;
        end;
      end;

      gmPrior:
      begin
        if FActualRecordId <= 1 then
        begin
          Result := grBOF;
          FActualRecordId := 0;
          FCurrentRec := nil;
        end
        else begin
          Dec(FActualRecordId);
          if FActualRecordId = RecordCount then
            FCurrentRec := FLastRow
          else
            FCurrentRec := FCurrentRec.Prior;
        end;
      end;

      gmCurrent:
        if (FActualRecordId <= 0) or (FActualRecordId > RecordCount) then
          Result := grError;
    end;
  end;
end;

function TSQLiteClientDataSet.OpenCurrentRecord: Boolean;

  procedure OpenOneStmt;
  var
    SQL: String;
  begin
    SQL := 'select * from ' + GetSQLiteTableName +
      ' where _ROWID_ = :R ' + GetSelectOrderBy;
    TSQLiteAux.PrepareSQL(SQL, FSelectOneStmt);
  end;

var
  FCur: PRecordNode;
begin
  FCur := PRecordBuffer(ActiveBuffer).Node;
  Result := FCur.Id > 0;
  if not Result then
    Exit;

  if (FCurrentOpenRec <> FCur) then
  begin
    if FSelectOneStmt = nil then
      OpenOneStmt
    else
      TSQLiteAux.CheckError(SQLite3_Reset(FSelectOneStmt));

    TSQLiteAux.CheckError(SQLite3_Bind_int64(FSelectOneStmt, 1, FCur.BdId));
    if Sqlite3_Step(FSelectOneStmt) <> SQLITE_ROW then
      raise Exception.CreateFmt('Row %d not found', [FCur.BdId]);
    FCurrentOpenRec := FCur;
  end;
end;

function TSQLiteClientDataSet.GetRecNo: Integer;
begin
  if Assigned(PRecordBuffer(ActiveBuffer).Node) then
    Result := PRecordBuffer(ActiveBuffer).Node.Id
  else
    Result := 0;
end;

function TSQLiteClientDataSet.GetRecord(Buffer: PByte; GetMode: TGetMode; DoCheck: Boolean): TGetResult;
begin
  Result := Navigate(GetMode);
  if (Result = grOk) then
  begin
    PRecordBuffer(Buffer).Node := FCurrentRec;
    ClearCalcFields(Buffer);
    GetCalcFields(Buffer);
  end
  else
  begin
    if Assigned(PRecordBuffer(Buffer).Node) and Bof and Eof then
    begin
      PRecordBuffer(Buffer).Node.Id := 0;
      PRecordBuffer(Buffer).Node.BdId := 0;
    end;

    if (Result = grError) and DoCheck then
      DatabaseError('No Records');
  end;
end;

function TSQLiteClientDataSet.GetRecordCount: Integer;
begin
  Result := FRecordCount;
end;

function TSQLiteClientDataSet.GetRecordSize: Word;
begin
  Result := Sizeof(Pointer) + SizeOf(TBookmarkFlag) + CalcFieldsSize;
end;

procedure TSQLiteClientDataSet.InternalAddRecord(Buffer: Pointer; Append: Boolean);
begin
  inherited;

end;

procedure TSQLiteClientDataSet.InternalClose;
begin
  inherited;
  SQLite3_Finalize(FSelectAllStmt);
  FSelectAllStmt := nil;
  SQLite3_Finalize(FSelectOneStmt);
  FSelectOneStmt := nil;

  FCursorOpen := False;
  FActualRecordId := 0;
  FCurrentRec := nil;
  FCurrentOpenRec := nil;

  BindFields(False);
  if DefaultFields then DestroyFields;
end;

procedure TSQLiteClientDataSet.InternalDelete;
begin
  inherited;

end;

procedure TSQLiteClientDataSet.InternalFirst;
begin
  inherited;
  FActualRecordId := 0;
  FCurrentRec := nil;
end;

procedure TSQLiteClientDataSet.InternalGotoBookmark(Bookmark: Pointer);
begin
  inherited;

end;

procedure TSQLiteClientDataSet.InternalHandleException;
begin
  inherited;

end;

procedure TSQLiteClientDataSet.MasterChanged(Sender: TObject);
begin
  BuildRowIdIndex;
  First;
end;

procedure TSQLiteClientDataSet.MasterDisabled(Sender: TObject);
begin

end;

procedure TSQLiteClientDataSet.DataEvent(Event: TDataEvent; Info: Integer);
begin
  case Event of
    deParentScroll: MasterChanged(Self);
  end;
  inherited;
end;

procedure TSQLiteClientDataSet.InternalInitFieldDefs;
begin
  inherited;
  FieldDefs.Clear;
  if Assigned(FDataSetProvider) and Assigned(FDataSetProvider.DataSet) then
    FieldDefs.Assign(FDataSetToSQLiteBind.GetBinding(FDataSetProvider.DataSet).FieldsDefs)
  else
  if Assigned(DataSetField) then
  begin
    FieldDefs.Assign(FDataSetToSQLiteBind.GetBinding(GetSQLiteTableName).FieldsDefs)
  end;
end;

procedure TSQLiteClientDataSet.InternalInitRecord(Buffer: PByte);
begin
  inherited;

end;

procedure TSQLiteClientDataSet.InternalLast;
begin
  inherited;
  FActualRecordId := RecordCount+1;
  FCurrentRec := nil;
end;

procedure TSQLiteClientDataSet.InternalOpen;
var
  RecsOut: Integer;
begin
  inherited;
  RecsOut := 0;
  if Assigned(FDataSetProvider) then
    FDataSetToSQLiteBind := Pointer(Integer(DoGetRecords(-1, RecsOut)))
  else
  if Assigned(DataSetField) then
    FDataSetToSQLiteBind := TSQLiteClientDataSet(DataSetField.DataSet).FDataSetToSQLiteBind;

  BuildRowIdIndex;
  FCursorOpen := True;
  FieldDefs.Updated := False;
  FieldDefs.Update;
  FieldDefList.Update;
  if DefaultFields then CreateFields;
  BindFields(True);
end;

procedure TSQLiteClientDataSet.InternalPost;
begin
  inherited;

end;

procedure TSQLiteClientDataSet.InternalSetToRecord(Buffer: PByte);
begin
  inherited;
  if Assigned(PRecordBuffer(Buffer).Node) then
  begin
    FActualRecordId := PRecordBuffer(Buffer).Node.Id;
    FCurrentRec := PRecordBuffer(Buffer).Node;
  end;
end;

function TSQLiteClientDataSet.IsCursorOpen: Boolean;
begin
  Result := FCursorOpen;
end;

function TSQLiteClientDataSet.Locate(const KeyFields: string;
  const KeyValues: Variant; Options: TLocateOptions): Boolean;

  function GenerateWhereLocate: String;
  var
    Fields: TStringList;
    i: Integer;
  begin
    Result := GetWhereClause;
    Fields := TStringList.Create;
    try
      Fields.Delimiter := ';';
      Fields.DelimitedText := KeyFields;
      for i := 0 to Fields.Count - 1 do
      begin
        Result := Result + Format('and %s = ''%s''', [Fields[i], KeyValues[i]])
      end;
      //Result := Copy(Result, 1, Length(Result)-4);
    finally
      Fields.Free;
    end;
  end;

var
  SQL: String;
  FLocateStmt: TSQLiteStmt;
  CurrentRec: PRecordNode;
  BdId: Integer;
begin
  Result := False;

  if RecordCount = 0 then
    Exit;

  if VarIsArray(KeyValues) then
    SQL := GenerateWhereLocate
  else
    SQL := Format('%s = ''%s''', [KeyFields, KeyValues]);

  SQL := 'select _ROWID_ from ' + GetSQLiteTableName + ' where ' + SQL + GetSelectOrderBy;
  //ShowMessage(SQL);

  TSQLiteAux.PrepareSQL(SQL, FLocateStmt);
  try
    if Sqlite3_Step(FLocateStmt) <> SQLITE_ROW then
      Result := False
    else
    begin
      BdId := Sqlite3_ColumnInt64(FLocateStmt, 0);
      if BdId = 0 then
        Exit;

      CurrentRec := FRootRow;
      while (CurrentRec <> nil) and (CurrentRec.BdId <> BdId) do
        CurrentRec := CurrentRec.Next;

      if Assigned(CurrentRec) then
      begin
        FCurrentRec := CurrentRec;
        Resync([rmExact, rmCenter]);
        Result := True;
      end;

    end;
  finally
    SQLite3_Finalize(FLocateStmt);
  end;
end;

function TSQLiteClientDataSet.DoGetRecords(Count: Integer; out RecsOut: Integer): OleVariant;
var
  OwnerData: OleVariant;
  OleParams: OleVariant;
begin
  DoBeforeGetRecords(OwnerData);
  if (Self.Params.Count > 0) then
    OleParams := PackageParams(Self.Params);
  Result := FDataSetProvider.GetRecords(Count, RecsOut, 0, '', OleParams, OwnerData);
  UnPackParams(OleParams, Self.Params);
  DoAfterGetRecords(OwnerData);
end;

procedure TSQLiteClientDataSet.DoBeforeGetRecords(var OwnerData: OleVariant);
begin
  if Assigned(FBeforeGetRecords) then FBeforeGetRecords(Self, OwnerData);
end;

function TSQLiteClientDataSet.GetSelectOrderBy: String;
begin
  Result := '';
  if Trim(FIndexFieldNames) <> '' then
    Result := ' order by ' + StringReplace(FIndexFieldNames, ',', ';', [rfReplaceAll]);
end;

function TSQLiteClientDataSet.GetSQLiteTableName: String;

  function FindLastOf(const C: char; const S: String): Integer;
  var
    i: Integer;
  begin
    Result := -1;
    for i := Length(S) downto 1 do
      if S[i] = C then
        Result := i;
  end;

var
  Rec: PINsertSQLiteRec;
  Root, DsName: String;
  P: Integer;
  MasterDataSet: TSQLiteClientDataSet;
begin
  if Assigned(FDataSetProvider) then
  begin
    Result := FDataSetToSQLiteBind.GetBinding(FDataSetProvider.DataSet).Table;
  end
  else
  if Assigned(DataSetField) then
  begin
    MasterDataSet := TSQLiteClientDataSet(DataSetField.DataSet);
    Rec := FDataSetToSQLiteBind.GetBinding(MasterDataSet.DataSetProvider.DataSet);
    P := FindLastOf('_', Rec.Table)+1;
    Root := Copy(Rec.Table, 1, P-1);
    DsName := Copy(Rec.Table, P, MaxInt);
    DsName := StringReplace(DataSetField.FieldName, DsName, '', []);
    Result := Root + DsName;
  end;
end;

function TSQLiteClientDataSet.GetWhereClause: String;
var
  i: Integer;
begin
  Result := ' where 1=1 ';
  with FDataSetToSQLiteBind.GetBinding(GetSQLiteTableName)^ do
  if Params.Count > 0 then
  begin
    for i := 0 to Params.Count - 1 do
      Result := Result + Format('and %s = :%s ', [Params[i].Name, Params[i].Name]);
    //Result := ' where ' + Copy(Result, 1, Length(Result)-4);
  end;
end;

procedure TSQLiteClientDataSet.BuildRowIdIndex;
var
  SQL: String;
  CurrentRow, PriorRow: PRecordNode;
  FetchResult: Integer;
begin
  SQL := 'select _ROWID_ from ' + GetSQLiteTableName + GetWhereClause + GetSelectOrderBy;

  PriorRow := nil;
  if (FRootRow = nil) then
    FRootRow := AllocRecordRow(PriorRow);
  CurrentRow := FRootRow;

  if not Assigned(FSelectAllStmt) then
    TSQLiteAux.PrepareSQL(SQL, FSelectAllStmt)
  else
    SQLite3_Reset(FSelectAllStmt);

  if Assigned(DataSetField) then
    SetParamsFromMaster(FSelectAllStmt, DataSetField.DataSet);

  FRecordCount := 0;
  try
    FetchResult := Sqlite3_Step(FSelectAllStmt);
    while (FetchResult = SQLITE_ROW) do
    begin
      if (CurrentRow = nil) then
        CurrentRow := AllocRecordRow(PriorRow);

      CurrentRow.BdId := Sqlite3_ColumnInt64(FSelectAllStmt, 0);
      CurrentRow.Id := FRecordCount+1;

      PriorRow := CurrentRow;
      CurrentRow := CurrentRow.Next;
      Inc(FRecordCount);

      FetchResult := Sqlite3_Step(FSelectAllStmt);
    end;

    // Don't need this memory anymore
    if FRecordCount = 0 then
      DestroyRecordList(FRootRow)
    else
    if PriorRow.Next <> nil then
      DestroyRecordList(PriorRow.Next);

    FLastRow := PriorRow;
    FCurrentRec := nil;
    FCurrentOpenRec := nil;

  finally
    TSQLiteAux.CheckError(SQLite3_Finalize(FSelectAllStmt));
    FSelectAllStmt := nil;
  end;
end;

constructor TSQLiteClientDataSet.Create(AOwner: TComponent);
begin
  inherited;
  FParams := TParams.Create(Self);
  FSelectAllStmt := nil;
  FSelectOneStmt := nil;
  FCurrentOpenRec := nil;
  FRootRow := nil;
  FRecordCount := 0;
  FRecordSize := 0;
  FCursorOpen := False;
  FActualRecordId := 0;
  FCurrentRec := nil;
  ObjectView := True;
  FMasterLink := TMasterDataLink.Create(Self);
  FMasterLink.OnMasterChange := MasterChanged;
  FMasterLink.OnMasterDisable := MasterDisabled;
end;

destructor TSQLiteClientDataSet.Destroy;
begin
  DestroyRecordList(FRootRow);
  FParams.Free;
  inherited;
end;

procedure TSQLiteClientDataSet.DoAfterGetRecords(var OwnerData: OleVariant);
begin
  if Assigned(FAfterGetRecords) then FAfterGetRecords(Self, OwnerData);
end;

procedure TSQLiteClientDataSet.SetBookmarkData(Buffer: PByte; Data: Pointer);
begin
  inherited;

end;

procedure TSQLiteClientDataSet.SetBookmarkFlag(Buffer: PByte; Value: TBookmarkFlag);
begin
  inherited;
  PRecordBuffer(Buffer).BookFlag := Value;
end;

procedure TSQLiteClientDataSet.SetDataSetField(const Value: TDataSetField);
begin
  if Assigned(FDataSetProvider) then
    FDataSetProvider := nil;
  inherited;
end;

procedure TSQLiteClientDataSet.SetDataSetProvider(
  const Value: TSQLiteDataSetProvider);
begin
  if Assigned(DataSetField) then
    SetDataSetField(nil);
  FDataSetProvider := Value;
end;

procedure TSQLiteClientDataSet.SetFieldData(Field: TField; Buffer: Pointer; NativeFormat: Boolean);
begin
  inherited;

end;

procedure TSQLiteClientDataSet.SetIndexFieldNames(const Value: String);
begin
  FIndexFieldNames := Value;
end;

procedure TSQLiteClientDataSet.SetParams(const Value: TParams);
begin
  FParams.Assign(Value);
end;

procedure TSQLiteClientDataSet.SetParamsFromMaster(stmt: TSQLiteStmt;
  Master: TDataSet);
var
  Params: TParams;
  i: Integer;
  pname, pvalue: AnsiString;
  pindex: Integer;
begin
  Params := FDataSetToSQLiteBind.GetBinding(GetSQLiteTableName).Params;
  for i := 0 to Params.Count - 1 do
  begin
    pname := ':' + AnsiString(Params[i].Name);
    pindex := SQLite3_Bind_Parameter_Index(stmt, PAnsiChar(pname));
    pvalue := Master.FieldByName(Params[i].Name).AsAnsiString;
    SQLite3_Bind_text(stmt, pindex, PAnsiChar(pvalue), -1, SQLITE_TRANSIENT);
  end;
end;

end.

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DBXFirebird, FMTBcd, Provider,
  DB, SqlExpr, Grids, DBGrids, DBClient, StdCtrls,
  ExtCtrls, SQLiteDataSetProvider, SQLiteClientDataSet;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    Panel1: TPanel;
    btnCDS: TButton;
    btnSiagri: TButton;
    SQLQuery2: TSQLQuery;
    DataSource2: TDataSource;
    DBGrid2: TDBGrid;
    Splitter1: TSplitter;
    ClientDataSet2: TClientDataSet;
    DataSource3: TDataSource;
    SQLiteClientDataSet1: TSQLiteClientDataSet;
    SQLiteClientDataSet2: TSQLiteClientDataSet;
    SQLiteDataSetProvider1: TSQLiteDataSetProvider;
    procedure btnCDSClick(Sender: TObject);
    procedure btnSiagriClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnCDSClick(Sender: TObject);
var
  i: Integer;
begin
  DataSource1.DataSet := ClientDataSet1;
  DataSource3.DataSet := ClientDataSet2;
  ClientDataSet1.Close;
  ClientDataSet1.Open;

  for i := 0 to ClientDataSet1.Fields.Count - 1 do
    if (ClientDataSet1.Fields[i] is TDataSetField) then
      ClientDataSet2.DataSetField := TDataSetField(ClientDataSet1.Fields[i]);
end;

procedure TForm1.btnSiagriClick(Sender: TObject);
var
  i: Integer;
begin
  DataSource1.DataSet := SQLiteClientDataSet1;
  DataSource3.DataSet := SQLiteClientDataSet2;
  SQLiteClientDataSet1.Close;
  SQLiteClientDataSet1.Open;

  for i := 0 to SQLiteClientDataSet1.Fields.Count - 1 do
    if (SQLiteClientDataSet1.Fields[i] is TDataSetField) then
      SQLiteClientDataSet2.DataSetField := TDataSetField(SQLiteClientDataSet1.Fields[i]);
end;

end.

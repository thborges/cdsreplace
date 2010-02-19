unit Unit10;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, WideStrings, FMTBcd, DBClient, Provider, DB, SqlExpr,
  Grids, DBGrids, StdCtrls, ExtCtrls, DBXOracle, DBXFirebird,
  SQLiteClientDataSet, SQLiteDataSetProvider;

type
  TForm10 = class(TForm)
    SQLQuery1: TSQLQuery;
    DataSetProvider1: TDataSetProvider;
    ClientDataSet1: TClientDataSet;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    SQLConnection2: TSQLConnection;
    DBGrid1: TDBGrid;
    SQLiteDataSetProvider1: TSQLiteDataSetProvider;
    SQLiteClientDataSet1: TSQLiteClientDataSet;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.Button1Click(Sender: TObject);
var
  a: Int64;
begin
  A := GetTickCount;
  ClientDataSet1.Open;
  ShowMessage(IntToStr(GetTickCount - A));
end;

procedure TForm10.Button2Click(Sender: TObject);
var
  a: Int64;
begin
  A := GetTickCount;
  SQLiteClientDataSet1.Open;
  ShowMessage(IntToStr(GetTickCount - A));
end;

end.

unit AppendRecordForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Grids, DBGrids, DB, SQLiteClientDataSet;

type
  TForm3 = class(TForm)
    SQLiteClientDataSet1: TSQLiteClientDataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    SQLiteClientDataSet1CODI: TIntegerField;
    SQLiteClientDataSet1NOME: TStringField;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
  SQLiteClientDataSet1.CreateDataSet;

  SQLiteClientDataSet1.Append;
  SQLiteClientDataSet1CODI.Value := 1;
  SQLiteClientDataSet1NOME.Value := 'THIAGO';
  SQLiteClientDataSet1.Post;

  SQLiteClientDataSet1.Append;
  SQLiteClientDataSet1CODI.Value := 2;
  SQLiteClientDataSet1NOME.Value := 'CRISTIANE';
  SQLiteClientDataSet1.Post;
end;

end.

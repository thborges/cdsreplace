program CuboTest;

uses
  Forms,
  CuboTestForm in 'CuboTestForm.pas' {Form2},
  SQLiteClientDataSet in '..\cds\SQLiteClientDataSet.pas',
  SQLiteDataSetProvider in '..\cds\SQLiteDataSetProvider.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

program CuboTest;

uses
  Forms,
  CuboTestForm in 'CuboTestForm.pas' {Form2},
  SQLiteClientDataSet in '..\cds\SQLiteClientDataSet.pas',
  SQLiteDataSetProvider in '..\cds\SQLiteDataSetProvider.pas',
  _uAsmProfDllInterface in '_uAsmProfDllInterface.pas',
  _uAsmProfDllLoader in '_uAsmProfDllLoader.pas';

{$R *.res}

begin
  Application.Initialize;
  //if LoadProfilerDll then ShowProfileForm;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.

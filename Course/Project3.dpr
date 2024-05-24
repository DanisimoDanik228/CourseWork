program Project3;

uses
  Vcl.Forms,
  uMain in 'uMain.pas' {Form1},
  uGarden in 'uGarden.pas' {Form2},
  uGlobalData in 'uGlobalData.pas',
  uGarden_Logical in 'uGarden_Logical.pas',
  uMain_Logical in 'uMain_Logical.pas',
  uAddNewCulture in 'uAddNewCulture.pas' {Form3},
  uAddNewGarden in 'uAddNewGarden.pas' {Form4},
  uShowAllGardens in 'uShowAllGardens.pas' {Form5},
  uDictionary in 'uDictionary.pas',
  uSP in 'uSP.pas' {Form6},
  uWorks in 'uWorks.pas' {Form7},
  uAddWork in 'uAddWork.pas' {Form8};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.Run;

end.

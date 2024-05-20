unit AddNewGarden;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, GlobalData,
  System.Generics.Collections;

type
  TForm4 = class(TForm)
    EditName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ColorBox1: TColorBox;
    ButtonSave: TButton;
    ButtonCancel: TButton;
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Res: TModalResult;
    { Private declarations }
  public
    function ShowForAdd(var garden: TGARDEN): TModalResult;
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

function IsValidInputData(const strName: string; const color: TColor): boolean;
var
  strmessage: string;
begin
  strmessage := '';

  if (StringReplace(strName, ' ', '', [rfReplaceAll]) = '') then
    strmessage := strmessage + '������� ������� ���' + #13#10;

  if IsColorAlreadyExist(color) then
    strmessage := strmessage + '����� ���� ��� �����������' + #13#10;

  if isNameGardenExist(strName) then
  begin
    strmessage := strmessage + '����� ��� ��� �����������' + #13#10;
  end;

  Result := strmessage = '';

  if (Result) then
  begin

  end
  else
  begin
    MessageBox(Application.Handle, PChar(strmessage), '������ �����', MB_OK);
  end;
end;

function TForm4.ShowForAdd(var garden: TGARDEN): TModalResult;
begin
  EditName.Text := '';

  ColorBox1.Selected := clBlack;

  Result := ShowModal;

  if Res = mrOk then
  begin
    inc(currMaxIdGarden);

    garden.Name := EditName.Text;
    garden.CodGarden := currMaxIdGarden;

    // showMessage('������ �����������   ' + inttostr(currMaxIdGarden));

    dictionaryColorToId.Add(currMaxIdGarden, ColorBox1.Selected);
  end;

  if Res = mrCancel then
  begin

  end;

  Result := Res;
end;

procedure TForm4.ButtonCancelClick(Sender: TObject);
begin
  Res := mrnone;
  Close();
end;

procedure TForm4.ButtonSaveClick(Sender: TObject);
begin
  if IsValidInputData(EditName.Text, ColorBox1.Selected) then
  begin
    Res := mrOk;
    Close();
  end;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Res := mrCancel;
end;

end.

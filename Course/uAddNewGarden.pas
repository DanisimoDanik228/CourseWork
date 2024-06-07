unit uAddNewGarden;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, uGlobalData,uDictionary;

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

    gardenlist: ptgarden;

    function IsValidInputData(const strName: string;
      const color: TColor): boolean;
  public
    function ShowForAdd(var garden: TGARDEN; gardenlist: ptgarden)
      : TModalResult;
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

function TForm4.IsValidInputData(const strName: string;
  const color: TColor): boolean;
  function IsColorAlreadyExist(const color: TColor): boolean;
  begin
    result := false;
    for var Item in dictionaryColorToId.GetAllItems do
    begin
      if Item.Value = color then
      begin
        result := true;
      end;
    end;
  end;
  function isNameGardenExist(const Name: string; list: ptgarden): boolean;
  begin
    result := false;

    if list = nil then
      exit;

    list := list.Next;

    if list = nil then
      exit;

    while list <> nil do
    begin
      if list.garden.Name = Name then
      begin
        result := true;
        exit;
      end;
      list := list.Next;
    end;
  end;

var
  strmessage: string;
begin
  strmessage := '';

  if (StringReplace(strName, ' ', '', [rfReplaceAll]) = '') then
    strmessage := strmessage + 'Неверно введено имя' + #13#10;

  if IsColorAlreadyExist(color) then
    strmessage := strmessage + 'Такой цвет уже применяется' + #13#10;

  if isNameGardenExist(strName, gardenlist) then
  begin
    strmessage := strmessage + 'Такое имя уже применяется' + #13#10;
  end;

  result := strmessage = '';

  if (result) then
  begin

  end
  else
  begin
    MessageBox(Application.Handle, PChar(strmessage), 'Ошибка ввода', MB_OK);
  end;
end;

function TForm4.ShowForAdd(var garden: TGARDEN; gardenlist: ptgarden)
  : TModalResult;
begin
  Form4.gardenlist := gardenlist;
  EditName.Text := '';

  ColorBox1.Selected := clBlack;

  result := ShowModal;

  if Res = mrOk then
  begin
    inc(currMaxIdGarden);

    garden.Name := EditName.Text;
    garden.CodGarden := currMaxIdGarden;

    // showMessage('индекс добавленого   ' + inttostr(currMaxIdGarden));

    dictionaryColorToId.Add(currMaxIdGarden, ColorBox1.Selected);
  end;

  if Res = mrCancel then
  begin

  end;

  result := Res;
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
  end  else
  Res := mrnone;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Res := mrCancel;
end;

end.

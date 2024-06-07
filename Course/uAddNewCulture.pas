unit uAddNewCulture;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uConstData, uGLOBALdATA;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    ButtonCancel: TButton;
    EditName: TEdit;
    Label3: TLabel;
    ButtonSave: TButton;
    Label4: TLabel;
    EditTime: TEdit;
    procedure ButtonCancelClick(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    culturelist: ptculture;

    Res: TModalResult;

    function IsValidInputData(const strName, strTime: string): boolean;
  public
    function ShowForAdd(var culture: cultureListInfo; culturelist: ptculture)
      : TModalResult;

  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

function TForm3.IsValidInputData(const strName, strTime: string): boolean;
  function isNameCultureExist(const Name: string; list: ptculture): boolean;
  begin
    result := false;

    if list = nil then
      exit;

    list := list.Next;

    if list = nil then
      exit;

    while list <> nil do
    begin
      if list.culture.Name = Name then
      begin
        result := true;
        exit;
      end;
      list := list.Next;
    end;
  end;

var
  strmessage: string;

  unusing: TMYDate;
begin
  strmessage := '';

  if not ConvertStringToDate(strTime, unusing) then
    strmessage := 'Неверная дата' + #13#10;

  if (StringReplace(strName, ' ', '', [rfReplaceAll]) = '') then
    strmessage := strmessage + 'Неверное имя' + #13#10;

  if isNameCultureExist(strName, culturelist) then
  begin
    strmessage := strmessage + 'Такой имя уже применяется' + #13#10;
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

function TForm3.ShowForAdd(var culture: cultureListInfo; culturelist: ptculture)
  : TModalResult;
var
  strmessage: string;
begin
  Form3.culturelist := culturelist;
  EditName.Text := '';
  EditTime.Text := '';

  result := ShowModal;

  if Res = mrOk then
  begin
    inc(currMaxIdCulture);

    culture.Name := EditName.Text;
    culture.cod := currMaxIdCulture;
    ConvertStringToDate(EditTime.Text, culture.Time);

    // showMessage('индекс добавленого   ' + inttostr(currMaxIdCulture));
  end;

  if Res = mrCancel then
  begin

  end;

  result := Res;
end;

procedure TForm3.ButtonCancelClick(Sender: TObject);
begin
  Res := mrnone;
  Close();
end;

procedure TForm3.ButtonSaveClick(Sender: TObject);
begin
  if IsValidInputData(EditName.Text, EditTime.Text) then
  begin
    Res := mrOk;
    Close();
  end
  else
  Res := mrnone;
end;

procedure TForm3.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  // Res := mrNone;
end;

end.

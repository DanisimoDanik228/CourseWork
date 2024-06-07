unit uAddWork;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, uglobaldata;

type
  TForm8 = class(TForm)
    EditName: TEdit;
    EditDesc: TEdit;
    Editdate: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    ButtonOk: TButton;
    Buttoncancel: TButton;

    procedure ButtonOkClick(Sender: TObject);
    procedure ButtonCancelClick(Sender: TObject);
  private
    masNames: array of string;
    res: TModalResult;
    function IsValidInputData(const str1: string): boolean;
    { Private declarations }
  public
    function ShowForEditing(var Task: worksRecord; ListView1: TLISTVIEW)
      : TModalResult;
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

function TForm8.ShowForEditing(var Task: worksRecord; ListView1: TLISTVIEW)
  : TModalResult;
begin
  setlength(masNames, ListView1.Items.Count);

  for var i := 0 to ListView1.Items.Count - 1 do
    masNames[i] := ListView1.Items[i].Caption;

  EditName.Text := Task.Name;
  EditDesc.Text := Task.Description;
  Editdate.Text := Task.Date;

  result := ShowModal;

  if res = mrOk then
  begin
    Task.Name := EditName.Text;
    Task.Description := EditDesc.Text;;
    Task.Date := Editdate.Text;
  end;

  result := res;
end;

function TForm8.IsValidInputData(const str1: string): boolean;
begin
 if '' = str1 then
    begin
      result := false;
      exit;
    end;

  for var item in masNames do
  begin
    if   item  = '"' + str1 + '"' then
    begin
      result := false;
      exit;
    end;
  end;
  result := True;
end;

procedure TForm8.ButtonCancelClick(Sender: TObject);
begin
  res := mrnone;
  Close();
end;

procedure TForm8.ButtonOkClick(Sender: TObject);
begin
  if IsValidInputData(EditName.Text) then
  begin
    res := mrOk;
    Close();
  end
  else
  begin
      MessageBox(Application.Handle, 'Неверно введённое имя '+#13#10 + '(название не может быть пустым)'+#13#10 + '(название должно быть уникальным)', 'Ошибка ввода', MB_OK);
  Res := mrnone;
  end;
end;

end.

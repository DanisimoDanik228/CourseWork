unit uSP;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, uglobaldata;

type
  TForm6 = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function MyShow(): TModalResult;
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation

{$R *.dfm}

function TForm6.MyShow(): TModalResult;
begin
  result := ShowModal;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
  Close();
end;

procedure TForm6.FormCreate(Sender: TObject);
begin
  Label1.Caption := textSP;
end;

end.

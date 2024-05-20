unit Form2Garden;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, GlobalData, Vcl.StdCtrls, ConstData,
  F2_Logical, Vcl.Menus, Vcl.Grids, AddNewCulture, AddNewGarden, Vcl.ComCtrls,
  System.Generics.Collections, System.Actions, Vcl.ActnList;

type
  TForm2 = class(TForm)
    LabelCulture: TLabel;
    LabelTime: TLabel;
    LabelBed: TLabel;
    ButtonSave: TButton;
    EditCulture: TEdit;
    EditTime: TEdit;
    EditGarden: TEdit;
    LabelGarden: TLabel;
    Label2: TLabel;
    ButtonClose: TButton;
    ButtonAddCulture: TButton;
    ButtonAddGarden: TButton;
    ListViewCulture: TListView;
    ListViewGarden: TListView;
    ButtonDeleteGarden: TButton;
    ButtonDeleteCulture: TButton;
    Button1: TButton;
    ActionListForm2: TActionList;
    ActionAddCulture: TAction;
    ActionAddGarden: TAction;
    ActionDeleteCulture: TAction;
    ActionDeleteGarden: TAction;
    procedure FormCreate(Sender: TObject);
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ListViewCultureClick(Sender: TObject);
    procedure CreateListViewGarden(list: PtGarden);
    procedure CreateListViewCulture(list: PtCulture);
    procedure ListViewGardenClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActionAddCultureExecute(Sender: TObject);
    procedure ActionAddGardenExecute(Sender: TObject);
    procedure ActionDeleteCultureExecute(Sender: TObject);
    procedure ActionDeleteGardenExecute(Sender: TObject);
  private
    CurrPoint: TPoint;
    StartPoint: TPoint;
    { Private declarations }
  public
    { Public declarations }
    procedure ReWriteFileGarden;
    procedure RewriteFileCulture;
    function FormShowForChange(CurrPoint: TPoint): TModalResult;
    function FormShowForChangeCtrl(CurrPoint, StartPoint: TPoint): TModalResult;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.RewriteFileCulture;
begin
  F2_Logical.RewriteFileCulture(culturelist);
end;

procedure TForm2.ReWriteFileGarden;
begin
  F2_Logical.ReWriteFileGarden(gardenlist);
end;

procedure TForm2.CreateListViewGarden(list: PtGarden);
var
  ListItem: TListItem;
  strColor: string;
begin
  ListViewGarden.Clear;

  ListViewGarden.Columns[0].Width := 100;
  ListViewGarden.Columns[1].Width := 100;

  list := list.Next;
  while list <> nil do
  begin
    ListItem := ListViewGarden.Items.Add;
    ListItem.Caption := list.garden.Name;
    strColor := ColorToString(IdentifyColor(list.garden.CodGarden));
    ListItem.SubItems.Add(Copy(strColor, 3, Length(strColor)));

    list := list.Next;
  end;

end;

procedure TForm2.CreateListViewCulture(list: PtCulture);
var
  ListItem: TListItem;
begin
  ListViewCulture.Clear;

  ListViewCulture.Columns[0].Width := 100;
  ListViewCulture.Columns[1].Width := 200;

  list := list.Next;
  while list <> nil do
  begin
    ListItem := ListViewCulture.Items.Add;
    // ShowMessage(list.culture.Name);
    ListItem.Caption := list.culture.Name;
    ListItem.SubItems.Add(ConvertDateToString(list.culture.Time));

    list := list.Next;
  end;

end;

procedure TForm2.ActionAddCultureExecute(Sender: TObject);
var
  Res: TModalResult;
  newculture: cultureListInfo;
begin
  Res := Form3.ShowForAdd(newculture);

  if Res = mrnone then
    Exit;

//  ShowMessage('add culture  result : ' + inttostr(ord(Res)));
  AddCulture(newculture, culturelist);
  CreateListViewCulture(culturelist);
end;

procedure TForm2.ActionAddGardenExecute(Sender: TObject);
var
  Res: TModalResult;
  newgarden: TGARDEN;

begin
  Res := Form4.ShowForAdd(newgarden);

  if Res = mrnone then
    Exit;

 // ShowMessage('add garden');

  AddGarden(newgarden, gardenlist);
  CreateListViewGarden(gardenlist);
end;

procedure TForm2.ActionDeleteCultureExecute(Sender: TObject);
var
  SelectedItem: TListItem;

begin
  if ListViewCulture.Selected <> nil then
  begin
    SelectedItem := ListViewCulture.Selected;
    if Assigned(SelectedItem) then
    begin
      if CheckCultureUsing(SelectedItem.Caption) then
      begin
        MessageBox(Application.Handle,
          '������ �������� ��� ������������ � ���������',
          '������ ��������', MB_OK);
      end
      else
      begin
        DeleteCulture(SelectedItem.Caption);
        CreateListViewCulture(culturelist);
      end;
    end;

  end
  else
  begin
    ShowMessage('Ex');
  end;
  ButtonDeleteCulture.Enabled := ListViewCulture.Selected <> nil;
end;

procedure TForm2.ActionDeleteGardenExecute(Sender: TObject);
var
  SelectedItem: TListItem;

begin
  if ListViewGarden.Selected <> nil then
  begin
    SelectedItem := ListViewGarden.Selected;
    if Assigned(SelectedItem) then
    begin
      if CheckGardenUsing(SelectedItem.Caption) then
      begin
        MessageBox(Application.Handle,
          '������ ������ ��� ������������ � ���������',
          '������ ��������', MB_OK);
      end
      else
      begin
        DeleteGarden(SelectedItem.Caption);
        CreateListViewGarden(gardenlist);
      end;
    end;
  end
  else
  begin
    ShowMessage('Ex');
  end;
  ButtonDeleteGarden.Enabled := ListViewCulture.Selected <> nil;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
showmessage('currMaxIdGarden : '+ inttostr(currMaxIdGarden));
  PrintCulture;
  PrintGarden;
  // PrintDictionary;
end;

procedure TForm2.ButtonCloseClick(Sender: TObject);
begin
  Close();
end;

procedure TForm2.ButtonSaveClick(Sender: TObject);
var
  culture: TGardenCell;
  strNameGarden: string[50];
  strNameCulture: string[50];
  I: Integer;
  strMessage: string;
begin
  strMessage := '';
  strNameCulture := EditCulture.Text;
  strNameGarden := EditGarden.Text;

  if not ConvertStringToDate(EditTime.Text, culture.�ulture.Time) then
    strMessage := '�������� ����';

  if not IsValidGarden(gardenlist, strNameGarden, culture.CodGarden) then
    strMessage := strMessage + #13#10 + '�������� ��� ������';

  if not IsValidCulture(culturelist, strNameCulture, culture.�ulture.cod) then
    strMessage := strMessage + #13#10 + '�������� ��� ��������';

  culture.�ulture.Name := strNameCulture;

  if (strMessage = '') then
  begin
    for var K := StartPoint.X to CurrPoint.X do
      for var J := StartPoint.Y to CurrPoint.Y do
      begin
        GardenMas[K][J] := culture;
      end;

    Close();

  end
  else
  begin

    MessageBox(Application.Handle, PChar(strMessage), '������ �����', MB_OK);
  end;
end;



procedure TForm2.FormCreate(Sender: TObject);
begin
  new(gardenlist);
  //
  ReadFileGarden(gardenlist);

  new(culturelist);
  //
  ReadFileCulture(culturelist);
end;

procedure TForm2.FormShow(Sender: TObject);
begin
  CreateListViewGarden(gardenlist);
  CreateListViewCulture(culturelist);
end;

function TForm2.FormShowForChange(CurrPoint: TPoint): TModalResult;
begin
  Form2.Caption := '��������� ������';

  ButtonDeleteCulture.Enabled := ListViewCulture.Selected <> nil;
  ButtonDeleteGarden.Enabled := ListViewGarden.Selected <> nil;

  Form2.CurrPoint := CurrPoint;
  Form2.StartPoint := CurrPoint;

  EditCulture.Text := IdentifyCultureName(culturelist,
    GardenMas[CurrPoint.X][CurrPoint.Y].�ulture.cod);

  EditTime.Text := ConvertDateToString(GardenMas[CurrPoint.X][CurrPoint.Y]
    .�ulture.Time);

  EditGarden.Text := IdentifyGardenName(gardenlist,
    GardenMas[CurrPoint.X][CurrPoint.Y].CodGarden);

  Result := ShowModal;
end;

function TForm2.FormShowForChangeCtrl(CurrPoint, StartPoint: TPoint)
  : TModalResult;
begin

  Form2.Caption := '��������� ������';

  Form2.CurrPoint := CurrPoint;
  Form2.StartPoint := StartPoint;

  EditCulture.Text := '';
  EditTime.Text := '';
  EditGarden.Text := '';

  Result := ShowModal;
end;

procedure TForm2.ListViewCultureClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  ButtonDeleteCulture.Enabled := ListViewCulture.Selected <> nil;

  SelectedItem := ListViewCulture.Selected;
  if Assigned(SelectedItem) then
  begin
    EditCulture.Text := SelectedItem.Caption;
    EditTime.Text := SelectedItem.SubItems[0];
  end;

end;

procedure TForm2.ListViewGardenClick(Sender: TObject);
var
  SelectedItem: TListItem;
begin
  ButtonDeleteGarden.Enabled := ListViewGarden.Selected <> nil;

  SelectedItem := ListViewGarden.Selected;
  if Assigned(SelectedItem) then
  begin
    EditGarden.Text := SelectedItem.Caption;
  end;
end;

end.

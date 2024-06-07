unit uGarden;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uGlobalData, Vcl.StdCtrls, uConstData,
  uGarden_Logical, Vcl.Menus, Vcl.Grids, uAddNewCulture, uAddNewGarden,
  Vcl.ComCtrls,
  System.Actions, Vcl.ActnList, uDictionary;

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
    procedure ButtonSaveClick(Sender: TObject);
    procedure ButtonCloseClick(Sender: TObject);
    procedure ListViewCultureClick(Sender: TObject);
    procedure CreateListViewGarden(list: PtGarden);
    procedure CreateListViewCulture(list: PtCulture);
    procedure ListViewGardenClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ActionAddCultureExecute(Sender: TObject);
    procedure ActionAddGardenExecute(Sender: TObject);
    procedure ActionDeleteCultureExecute(Sender: TObject);
    procedure ActionDeleteGardenExecute(Sender: TObject);
  private
    CurrPoint: TPoint;
    StartPoint: TPoint;

    culturelist: PtCulture;
    gardenlist: PtGarden;
    { Private declarations }
  public
    { Public declarations }
    function FormShowForChange(CurrPoint: TPoint): TModalResult;
    function FormShowForChangeCtrl(CurrPoint, StartPoint: TPoint): TModalResult;
    procedure createLists(culturelist: PtCulture; gardenlist: PtGarden);
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.createLists(culturelist: PtCulture; gardenlist: PtGarden);
begin
  Form2.culturelist := culturelist;
  Form2.gardenlist := gardenlist;
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
  Res := Form3.ShowForAdd(newculture, culturelist);

  if Res = mrnone then
    Exit;

  // ShowMessage('add culture  result : ' + inttostr(ord(Res)));
  AddCulture(newculture, culturelist);
  CreateListViewCulture(culturelist);
end;

procedure TForm2.ActionAddGardenExecute(Sender: TObject);

var
  Res: TModalResult;
  newgarden: TGARDEN;

begin
  Res := Form4.ShowForAdd(newgarden, gardenlist);

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
          'Данная культура уже используется в хозяйтсве',
          'Ошибка удаления', MB_OK);
      end
      else
      begin
        DeleteCulture(SelectedItem.Caption, culturelist);
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
      if CheckGardenUsing(getidgarden(SelectedItem.Caption, gardenlist)) then
      begin
        MessageBox(Application.Handle,
          'Данная грядка уже используется в хозяйтсве',
          'Ошибка удаления', MB_OK);
      end
      else
      begin
        DeleteGarden(SelectedItem.Caption, gardenlist);
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
  // ShowMessage('currMaxIdGarden : ' + inttostr(currMaxIdGarden));
  // PrintCulture(culturelist);
  // PrintGarden(dictionaryColorToId, gardenlist);
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
  I: integer;
  strMessage: string;
begin
  strMessage := '';
  strNameCulture := EditCulture.Text;
  strNameGarden := EditGarden.Text;

  if not ConvertStringToDate(EditTime.Text, culture.Сulture.Time) then
    strMessage := 'Неверная дата';

  if not IsValidGarden(gardenlist, strNameGarden, culture.CodGarden) then
    strMessage := strMessage + #13#10 + 'Неверное имя грядки';

  if not IsValidCulture(culturelist, strNameCulture, culture.Сulture.cod) then
    strMessage := strMessage + #13#10 + 'Неверное имя культуры';

  culture.Сulture.Name := strNameCulture;

  if (strMessage = '') then
  begin
    for var K := StartPoint.X to CurrPoint.X do
      for var J := StartPoint.Y to CurrPoint.Y do
      begin
        gardenmas[K][J] := culture;
      end;

    Close();

  end
  else
  begin

    MessageBox(Application.Handle, PChar(strMessage), 'Ошибка ввода', MB_OK);
  end;
end;

function TForm2.FormShowForChange(CurrPoint: TPoint): TModalResult;
  function IdentifyGardenName(list: PtGarden; const cod: integer): string;
  begin
    list := list.Next;
    while list <> nil do
    begin
      if list.garden.CodGarden = cod then
      begin
        result := list.garden.Name;
        break;
      end;
      list := list.Next;
    end;
  end;

  function IdentifyCultureName(list: PtCulture; const cod: integer): string;
  begin
    list := list.Next;
    while list <> nil do
    begin
      if list.culture.cod = cod then
      begin
        result := list.culture.Name;
        break;
      end;
      list := list.Next;
    end;
  end;

begin
  CreateListViewGarden(gardenlist);
  CreateListViewCulture(culturelist);

  Form2.Caption := 'Изменение грядки';

  ButtonDeleteCulture.Enabled := ListViewCulture.Selected <> nil;
  ButtonDeleteGarden.Enabled := ListViewGarden.Selected <> nil;

  Form2.CurrPoint := CurrPoint;
  Form2.StartPoint := CurrPoint;

  EditCulture.Text := IdentifyCultureName(culturelist,
    gardenmas[CurrPoint.X][CurrPoint.Y].Сulture.cod);

  EditTime.Text := ConvertDateToString(gardenmas[CurrPoint.X][CurrPoint.Y]
    .Сulture.Time);

  EditGarden.Text := IdentifyGardenName(gardenlist,
    gardenmas[CurrPoint.X][CurrPoint.Y].CodGarden);

  result := ShowModal;
end;

function TForm2.FormShowForChangeCtrl(CurrPoint, StartPoint: TPoint): TModalResult;
begin


  CreateListViewGarden(gardenlist);
  CreateListViewCulture(culturelist);

  Form2.Caption := 'Изменение грядок';

  Form2.CurrPoint := CurrPoint;
  Form2.StartPoint := StartPoint;

  EditCulture.Text := '';
  EditTime.Text := '';
  EditGarden.Text := '';

  result := ShowModal;
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

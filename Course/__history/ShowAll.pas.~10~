unit ShowAll;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, GlobalData, ConstData,
  Vcl.StdCtrls, Vcl.ComCtrls, System.Generics.Collections;

type
  TForm5 = class(TForm)
    PaintBox1: TPaintBox;
    ListViewGarden: TListView;
    Label1: TLabel;
    Button1: TButton;
    Panel1: TPanel;
    Label2: TLabel;
    ListViewCulture: TListView;
    Label3: TLabel;
    ListViewCultureAll: TListView;

    procedure PrintSelectedCulture(const nameCulture: string);
    procedure CreateListViewGarden(list: PtGarden);
    procedure PaintRect(const x, y: integer; const color: Tcolor;
      const brush: Tcolor);
    procedure PaintBox1Paint(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ListViewGardenClick(Sender: TObject);
    procedure PrintSelectedGarden(const idGarden: integer);
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreateListViewCulture(const idGarden: array of integer);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer);
    procedure CreateListCultureAll(CultutrList: ptCulture);
    procedure ListViewCultureAllClick(Sender: TObject);
    procedure printAllGarden;
  private
    { Private declarations }
  public
    function FormShowAll: TModalResult;
    { Public declarations }
  end;

var
  Form5: TForm5;

const
  SizeRect = 20;
  SizePen = 2;
  // BrightenColor(öâåò,ïðîöåíò ÿðêîñòè) :TColor;

implementation

{$R *.dfm}

procedure TForm5.printAllGarden;
begin
  PaintBox1.Canvas.brush.color := clBtnFace;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);

  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin
      PaintRect(i, j, clsilver, IdentifyColor(GardenMas[i][j].CodGarden));
    end;
  end;
end;

procedure TForm5.CreateListCultureAll(CultutrList: ptCulture);
var
  Column: TListColumn;
  listitem: tlistitem;
begin
  ListViewCultureAll.Clear();

  CultutrList := CultutrList.Next;
  while CultutrList <> nil do
  begin
    listitem := ListViewCultureAll.Items.Add;
    listitem.Caption := CultutrList.culture.Name;
    CultutrList := CultutrList.Next;
  end;

end;

procedure TForm5.PrintSelectedCulture(const nameCulture: string);
var
  Rect: TRect;
begin

  printAllGarden;
  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin
      if GardenMas[i][j].Ñulture.Name = nameCulture then
      begin
        PaintBox1.Canvas.brush.color :=clsilver  ;
        PaintBox1.Canvas.Pen.color := IdentifyColor(GardenMas[i][j].CodGarden);
        Rect.Create(i * SizeRect + SizePen , j * SizeRect + SizePen,
          (i) * SizeRect  + sizerect * 2 div 3, (j) * SizeRect  + sizerect * 2 div 3);
        PaintBox1.Canvas.Rectangle(Rect);

       // PaintRect(i, j, IdentifyColor(GardenMas[i][j].CodGarden), clsilver);
      end;
    end;
  end;

end;

procedure TForm5.PrintSelectedGarden(const idGarden: integer);
begin
  // PaintBox1.Canvas.brush.color := clBtnFace;
  // PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);

  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin
      PaintRect(i, j, IdentifyColor(GardenMas[i][j].CodGarden), clsilver);
    end;
  end;

  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin
      if GardenMas[i][j].CodGarden = idGarden then
      begin
        PaintRect(i, j, clsilver, IdentifyColor(GardenMas[i][j].CodGarden));
      end;
    end;
  end;

end;

procedure TForm5.Button1Click(Sender: TObject);

var
  MySet: array of integer;
  function IsCodExist(const digits: integer): boolean;
  begin
    Result := false;
    for var item in MySet do
    begin
      if item = digits then
      begin
        Result := true;
        break;
      end;
    end;

  end;

begin

  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin

      PaintRect(i, j, clsilver, IdentifyColor(GardenMas[i][j].CodGarden));
      if not IsCodExist(GardenMas[i][j].CodGarden) then
      begin
        setLength(MySet, length(MySet) + 1);
        MySet[length(MySet) - 1] := GardenMas[i][j].CodGarden;
      end;
    end;
  end;

  ListViewCulture.Clear;
  CreateListViewCulture(MySet);
end;

procedure TForm5.CreateListViewCulture(const idGarden: array of integer);
var
  FrequensChars: TDictionary<string, integer>;
  listitem: tlistitem;
begin
  FrequensChars := TDictionary<string, integer>.Create;
  for var k := Low(idGarden) to High(idGarden) do
  begin
    for var i := 0 to _GardenX do
    begin
      for var j := 0 to _GardenY do
      begin
        if GardenMas[i][j].CodGarden = idGarden[k] then
        begin
          if FrequensChars.ContainsKey(GardenMas[i][j].Ñulture.Name) then
          begin
            FrequensChars[GardenMas[i][j].Ñulture.Name] :=
              FrequensChars[GardenMas[i][j].Ñulture.Name] + 1;
          end
          else
          begin
            FrequensChars.Add(GardenMas[i][j].Ñulture.Name, 1);
          end;
          // ListItem := ListViewCulture.Items.Add;
          // ListItem.Caption := GardenMas[i][j].Ñulture.Name;
        end;

        // PaintRect(i, j, IdentifyColor(GardenMas[i][j].CodGarden), clSilver);
      end;
    end
  end;
  for var item in FrequensChars.Keys do
  begin

    listitem := ListViewCulture.Items.Add;
    listitem.Caption := item; // + '  x' + inttostr(FrequensChars[item]);
    listitem.SubItems.Add(inttostr(FrequensChars[item]));
    // RichEdit1.Lines.Add(item + '  x' + inttostr(FrequensChars[item]));
  end;

end;

procedure TForm5.CreateListViewGarden(list: PtGarden);
var
  listitem: tlistitem;
  strColor: string;
begin
  ListViewGarden.Clear;

  list := list.Next;
  while list <> nil do
  begin
    listitem := ListViewGarden.Items.Add;
    listitem.Caption := list.garden.Name;
    strColor := ColorToString(IdentifyColor(list.garden.CodGarden));
    listitem.SubItems.Add(Copy(strColor, 3, length(strColor)));

    list := list.Next;
  end;

end;

procedure TForm5.FormCreate(Sender: TObject);
var
  Column: TListColumn;
  x: integer;
begin

  Column := ListViewGarden.Columns.Add;
  Column.Caption := 'Ãðÿäêà';
  Column := ListViewGarden.Columns.Add;
  Column.Caption := 'Öâåò';
  ListViewGarden.Columns[0].Width := 150;
  ListViewGarden.Columns[1].Width := 150;

  Column := ListViewCulture.Columns.Add;
  Column.Caption := 'Êóëüòóðà';
  Column := ListViewCulture.Columns.Add;
  Column.Caption := 'Êîë-âî';
  ListViewCulture.Columns[0].Width := 80;
  ListViewCulture.Columns[1].Width := 80;

  Column := ListViewCultureAll.Columns.Add;
  Column.Caption := 'Êóëüòóðà';
  ListViewCultureAll.Columns[0].Width := 150;

  Panel1.color := clCream;

  PaintBox1.Width := _GardenX * (SizeRect); // + sizepen);
  PaintBox1.Height := _GardenY * (SizeRect); // + sizepen);

  Panel1.Width := PaintBox1.Width + 2 * 7;
  Panel1.Height := PaintBox1.Height + 2 * 7;

  // Panel1.Left := ClientWidth - Panel1.Width;
  // Panel1.Top := 0;

  PaintBox1.Left := 7;
  PaintBox1.Top := 7;

end;

procedure TForm5.FormShow(Sender: TObject);
begin
  ListViewCulture.Clear;
  ListViewGarden.Clear;

  CreateListViewGarden(Gardenlist);
  CreateListCultureAll(CultureList);

  Button1.Click();
end;

function TForm5.FormShowAll: TModalResult;
begin
  Result := ShowModal;
  CreateListCultureAll(CultureList);
end;

procedure TForm5.ListViewCultureAllClick(Sender: TObject);
var
  SelectedItem: tlistitem;
begin
  SelectedItem := ListViewCultureAll.Selected;
  if SelectedItem <> nil then
  begin
    if Assigned(SelectedItem) then
    begin
      PrintSelectedCulture(SelectedItem.Caption);
    end;
  end;
end;

procedure TForm5.ListViewGardenClick(Sender: TObject);
var
  SelectedItem: tlistitem;
begin
  SelectedItem := ListViewGarden.Selected;
  if SelectedItem <> nil then
  begin
    if Assigned(SelectedItem) then
    begin
      PrintSelectedGarden(getIdGarden(SelectedItem.Caption));
    end;

    ListViewCulture.Clear;
    CreateListViewCulture(getIdGarden(SelectedItem.Caption));
  end;
end;

procedure TForm5.PaintRect(const x, y: integer; const color: Tcolor;
  const brush: Tcolor);
var
  Rect: TRect;
begin
  PaintBox1.Canvas.brush.color := brush;
  PaintBox1.Canvas.Pen.color := color;
  Rect.Create(x * SizeRect + SizePen, y * SizeRect + SizePen,
    (x + 1) * SizeRect, (y + 1) * SizeRect);
  PaintBox1.Canvas.Rectangle(Rect);
end;

procedure TForm5.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer);
var
  idGarden: integer;
begin
  idGarden := GardenMas[x div SizeRect][y div SizeRect].CodGarden;

  PrintSelectedGarden(idGarden);
  ListViewCulture.Clear;

  CreateListViewCulture(idGarden);
end;

procedure TForm5.PaintBox1Paint(Sender: TObject);
begin
  printAllGarden;
end;

end.

unit uWorks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.WinXCtrls,
  Vcl.ComCtrls, Vcl.StdCtrls, uglobaldata, uaddwork;

type
  TForm7 = class(TForm)
    SplitView1: TSplitView;
    ListView1: TListView;
    SplitView2: TSplitView;
    ButtonAdd: TButton;
    ButtonDelete: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure createListView1(list: ptworks);
    procedure ButtonAddClick(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure ButtonDeleteClick(Sender: TObject);
  private
    listWorks: ptworks;
    procedure Add(const newwork: worksRecord);
    procedure Delete(const name: string);
    { Private declarations }
  public
    function MyShow(list: ptworks): TModalResult;
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.ButtonAddClick(Sender: TObject);
var
  work: worksRecord;
begin
  work.name := '';
  work.Description := '';
  work.Date := '';
  if Form8.ShowForEditing(work, ListView1) = mrok then
  begin
    Add(work);
  end;

  ButtonDelete.Enabled := ListView1.Selected <> nil;
end;

procedure TForm7.Add(const newwork: worksRecord);
var
  firstNode: ptworks;
begin
  firstNode := listWorks.next;

  new(listWorks.next);
  listWorks.next.work := newwork;
  listWorks.next.next := firstNode;

  createListView1(listWorks);
end;

procedure TForm7.createListView1(list: ptworks);
var
  Column: TListColumn;
  listitem: TListItem;
begin
  ListView1.Clear();

  list := list.next;
  while list <> nil do
  begin
    listitem := ListView1.Items.Add;
    listitem.Caption := '"' + list.work.name + '"';
    listitem.SubItems.Add(list.work.Description);
    listitem.SubItems.Add(list.work.Date);
    list := list.next;
  end;

end;

function TForm7.MyShow(list: ptworks): TModalResult;
begin
  listWorks := list;
  result := showmodal;
  createListView1(listWorks);
end;

procedure TForm7.Delete(const name: string);
 function CompareStrings(const Str1, Str2: string): Boolean;
begin
  Result := Str1 = Str2;
end;
var
  list: ptworks;
begin
  list := listWorks;
  while (list.next <> nil) and (not CompareStrings( list.next.work.name , name)) do
  begin
    list := list.next;
  end;

  if (list.next <> nil) and ( CompareStrings( list.next.work.name , name)) then
  begin
    list.next := list.next.next;
  end;
end;

procedure TForm7.ButtonDeleteClick(Sender: TObject);
 function RemoveFirstAndLastChar(const Input: string): string;
begin
  if Length(Input) <= 2 then
    Result := ''
  else
    Result := Copy(Input, 2, Length(Input) - 2);
end;
var
  SelectedItem: TListItem;
begin
  if ListView1.Selected <> nil then
  begin
    SelectedItem := ListView1.Selected;
    if Assigned(SelectedItem) then
    begin
      Delete(RemoveFirstAndLastChar(SelectedItem.Caption));

      createListView1(listWorks);
    end;
  end
  else
  begin
    ShowMessage('Ex');
  end;
   ButtonDelete.Enabled := ListView1.Selected <> nil;
end;

procedure TForm7.FormCreate(Sender: TObject);
var
  Column: TListColumn;
begin

  Column := ListView1.Columns.Add;
  Column.Caption := '�������� ����';
  Column := ListView1.Columns.Add;
  Column.Caption := '��������';
  Column := ListView1.Columns.Add;
  Column.Caption := '��������������� ����';
  ListView1.Columns[0].Width := 150;
  ListView1.Columns[1].Width := 150;
  ListView1.Columns[2].Width := 250;

  new(listWorks);
end;

procedure TForm7.FormShow(Sender: TObject);
begin
  ButtonDelete.Enabled := ListView1.Selected <> nil;
  createListView1(listWorks);
end;

procedure TForm7.ListView1Click(Sender: TObject);
begin
  ButtonDelete.Enabled := ListView1.Selected <> nil;

end;

end.

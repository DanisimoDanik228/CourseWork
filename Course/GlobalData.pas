unit GlobalData;

interface

uses
  Types, Graphics, ConstData, sysUtils,
  Vcl.Dialogs, MyDictionary;

type

  Tstring = string[50];

  TMyDate = record
    Year: integer;
    Month: integer;
    Days: integer;
  end;

  Ptculture = ^cultureRecord;

  cultureListInfo = record
    Name: string[50];
    Time: TMyDate;
    cod: integer;
  end;

  cultureRecord = record
    culture: cultureListInfo;
    Next: Ptculture;
  end;

  PtGarden = ^GardenRecord;

  TGarden = record
    CodGarden: integer;
    Name: string[50];
  end;

  GardenRecord = record
    garden: TGarden;
    Next: PtGarden;
  end;

  TGardenCell = record
    CodGarden: integer;
    �ulture: cultureListInfo;
  end;

  RecordDictionary = record
    Color: TColor;
    corGarden: integer;
  end;

  TgardenMas = array [0 .. _GardenX] of array [0 .. _GardenY] of TGardenCell;

var
  dictionaryColorToId: TMyDictionary<integer, TColor>;
  GardenMas: TgardenMas;

  currMaxIdCulture: integer;
  currMaxIdGarden: integer;

function IdentifyColor(const cod: integer): TColor;
function ConvertStringToDate(const dateStr: string; var date: TMyDate): boolean;
function ConvertDateToString(const dateStr: TMyDate): string;
 function GetIdGarden(const Name: string; list: PtGarden): integer;
//procedure PrintGarden(dictionaryColorToId: TMyDictionary<integer, TColor>;
//  list: PtGarden);
//procedure PrintDictionary(dictionaryColorToId: TMyDictionary<integer, TColor>);
//procedure PrintCulture(list: Ptculture);

implementation

function GetIdGarden(const Name: string; list: PtGarden): integer;
begin
  list := list.Next;
  result := -1;
  try
    while list <> nil do
    begin
      if list.garden.Name = Name then
      begin
        result := list.garden.CodGarden;
        break;
      end;
      list := list.Next;
    end;

  except
    ShowMessage('������ ����� � ������� �� ����������');
  end;

  if result = -1 then
  begin

    ShowMessage('������ ����� � ������� �� ����������');
  end;
end;

procedure PrintDictionary(dictionaryColorToId: TMyDictionary<integer, TColor>);
var
  str: string;
begin
  str := 'Dictionary' + #13#10;
  for var temp in dictionaryColorToId.GetAllItems do
  begin
    str := str + #13#10 + inttostr(temp.Key) + '  |  ' +
      ColorToString(temp.Value);
  end;

  ShowMessage(str);
end;

procedure PrintGarden(dictionaryColorToId: TMyDictionary<integer, TColor>;
  list: PtGarden);
var
  str: string;
begin
  str := 'Garden' + #13#10;
  list := list.Next;
  while list <> nil do
  begin
    str := str + #13#10 + inttostr(list.garden.CodGarden) + '  |  ' +
      list.garden.Name + '  --> ';
    if dictionaryColorToId.ContainsKey(list.garden.CodGarden) then
    begin
      str := str + ColorToString(dictionaryColorToId[list.garden.CodGarden]);
    end
    else
    begin
      str := str + 'error';
    end;

    list := list.Next;
  end;
  ShowMessage(str);
end;

procedure PrintCulture(list: Ptculture);
var
  str: string;
begin
  str := 'culture' + #13#10;
  list := list.Next;

  while list <> nil do
  begin
    str := str + #13#10 + inttostr(list.culture.cod) + '  |  ' +
      list.culture.Name + '  |  ' + ConvertDateToString(list.culture.Time);
    list := list.Next;
  end;
  ShowMessage(str);
end;

function IdentifyColor(const cod: integer): TColor;
begin
  result := dictionaryColorToId[cod];
end;

function ConvertStringToDate(const dateStr: string; var date: TMyDate): boolean;
begin
  ConvertStringToDate := true;
  try
    date.Days := StrToInt((dateStr[1] + dateStr[2]));
    date.Month := StrToInt((dateStr[4] + dateStr[5]));
    date.Year := StrToInt((dateStr[7]));
  except
    ConvertStringToDate := false;
  end;

  if (Length(dateStr) <> 7) or (dateStr[3] <> ':') or (dateStr[6] <> ':') then
    ConvertStringToDate := false;

end;

function ConvertDateToString(const dateStr: TMyDate): string;
begin
  result := inttostr(dateStr.Days);
  if dateStr.Days < 10 then
  begin
    result := '0' + result;
  end;

  result := result + ':';

  if dateStr.Month < 10 then
  begin
    result := result + '0';
  end;
  result := result + inttostr(dateStr.Month) + ':' + inttostr(dateStr.Year);

end;

end.

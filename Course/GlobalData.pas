unit GlobalData;

interface

uses
  Types, Graphics, ConstData, sysUtils, System.Generics.Collections,
  Vcl.Dialogs;

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
    Сulture: cultureListInfo;
  end;

  RecordDictionary = record
    Color: TColor;
    corGarden: integer;
  end;

var
  dictionaryColorToId: TDictionary<integer, TColor>;

  CultureList: Ptculture;
  GardenList: PtGarden;

  currMaxIdCulture: integer;
  currMaxIdGarden: integer;

  GardenMas: array [0 .. _GardenX] of array [0 .. _GardenY] of TGardenCell;

function IdentifyColor(const cod: integer): TColor; overload;
function IdentifyColor(const nameGarden: string; list: PtGarden)
  : TColor; overload;
function IsValidGarden(list: PtGarden; const str: string;
  var cod: integer): boolean;
function IsValidCulture(list: Ptculture; const str: string;
  var cod: integer): boolean;
function IdentifyGardenName(list: PtGarden; const cod: integer): string;
function IdentifyCultureName(list: Ptculture; const cod: integer): string;
function ConvertStringToDate(const dateStr: string; var date: TMyDate): boolean;
function ConvertDateToString(const dateStr: TMyDate): string;
procedure AddCulture(const newCulture: cultureListInfo; list: Ptculture);
procedure AddGarden(const newgARDEN: TGarden; list: PtGarden);
function IsColorAlreadyExist(const Color: TColor): boolean;
function GetIdCulture(const Name: string): integer;
function GetIdGarden(const Name: string): integer;
procedure PrintGarden;
procedure PrintDictionary;
procedure PrintCulture;
function isNameCultureExist(const Name: string): boolean;
function isNameGardenExist(const Name: string): boolean;
function CreateDate(const AYear, AMonth, ADays: integer): TMyDate;

implementation

function isNameCultureExist(const Name: string): boolean;
var
  list: Ptculture;
begin
  result := false;
  list := CultureList;

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

function isNameGardenExist(const Name: string): boolean;
var
  list: Ptgarden;
begin
  result := false;
  list := gardenList;

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
function CreateDate(const AYear, AMonth, ADays: integer): TMyDate;
begin
  CreateDate.Year := AYear;
  CreateDate.Month := AMonth;
  CreateDate.Days := ADays;
end;

procedure PrintDictionary;
var
  str: string;
begin
  str := 'Dictionary' + #13#10;
  for var temp in dictionaryColorToId do
  begin
    str := str + #13#10 + inttostr(temp.Key) + '  |  ' +
      ColorToString(temp.Value);
  end;

  ShowMessage(str);
end;

procedure PrintGarden;
var
  list: PtGarden;
  str: string;
begin
  str := 'Garden' + #13#10;
  list := GardenList.Next;

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

procedure PrintCulture;
var
  list: Ptculture;
  str: string;
begin
  str := 'culture' + #13#10;
  list := CultureList.Next;

  while list <> nil do
  begin
    str := str + #13#10 + inttostr(list.culture.cod) + '  |  ' +
      list.culture.Name + '  |  ' + ConvertDateToString(list.culture.Time);
    list := list.Next;
  end;
  ShowMessage(str);
end;

function GetIdCulture(const Name: string): integer;
var
  list: Ptculture;
begin
  list := CultureList.Next;
  result := -1;
  try
    while list <> nil do
    begin
      if list.culture.Name = Name then
      begin
        result := list.culture.cod;
        break;
      end;
      list := list.Next;
    end;

  except
    ShowMessage('Такого имени в культурах не существует');
  end;

  if result = -1 then
    ShowMessage('Такого имени в культурах не существует');
end;

function GetIdGarden(const Name: string): integer;
var
  list: PtGarden;
begin
  list := GardenList.Next;
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
    ShowMessage('Такого имени в грядках не существует');
  end;

  if result = -1 then
  begin

    ShowMessage('Такого имени в грядках не существует');
  end;
end;

function IsColorAlreadyExist(const Color: TColor): boolean;
begin
  result := false;
  for var Item in dictionaryColorToId.Values do
  begin
    if Item = Color then
    begin
      result := true;
    end;
  end;
end;

function IdentifyColor(const cod: integer): TColor;
begin
  if dictionaryColorToId.ContainsKey(cod) then
  begin
    result := dictionaryColorToId[cod];
  end
  else
  begin
    ShowMessage('not fount key :' + inttostr(cod));
    result := clWhite;
  end;

end;

function IdentifyColor(const nameGarden: string; list: PtGarden): TColor;
begin
  list := list.Next;

  while list <> nil do
  begin
    if list.garden.Name = nameGarden then
    begin
      IdentifyColor := IdentifyColor(list.garden.CodGarden);
      break;
    end;
    list := list.Next;
  end;
end;

function IsValidGarden(list: PtGarden; const str: string;
  var cod: integer): boolean;
var
  start: PtGarden;
begin
  result := false;
  start := GardenList;

  GardenList := GardenList.Next;
  while GardenList <> nil do
  begin
    if GardenList.garden.Name = str then
    begin
      result := true;
      cod := GardenList.garden.CodGarden;
      break;
    end;
    GardenList := GardenList.Next;
  end;

  GardenList := start;
end;

function IsValidCulture(list: Ptculture; const str: string;
  var cod: integer): boolean;
var
  start: Ptculture;
begin
  result := false;
  start := CultureList;

  CultureList := CultureList.Next;
  while CultureList <> nil do
  begin
    if CultureList.culture.Name = str then
    begin
      result := true;
      cod := CultureList.culture.cod;
      break;
    end;
    CultureList := CultureList.Next;
  end;

  CultureList := start;
end;

function IdentifyGardenName(list: PtGarden; const cod: integer): string;
begin
  list := GardenList.Next;
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

function IdentifyCultureName(list: Ptculture; const cod: integer): string;
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

procedure AddCulture(const newCulture: cultureListInfo; list: Ptculture);
var
  firstNode: Ptculture;
begin
  firstNode := list.Next;

  new(list.Next);
  list.Next.culture := newCulture;
  list.Next.Next := firstNode;
end;

procedure AddGarden(const newgARDEN: TGarden; list: PtGarden);
var
  firstNode: PtGarden;
begin
  firstNode := list.Next;

  new(list.Next);
  list.Next.garden := newgARDEN;
  list.Next.Next := firstNode;
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

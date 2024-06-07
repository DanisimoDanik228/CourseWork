unit uGarden_Logical;

interface

uses
  uConstData, uGLOBALdATA, SysUtils, Vcl.Dialogs,
  Graphics, udictionary;

function CheckCultureUsing(const culture: string): boolean;
function CheckGardenUsing(const gardencod: integer): boolean;
procedure DeleteCulture(const name: string; list: Ptculture);
procedure DeleteGarden(const name: string; list: ptgarden);
procedure AddCulture(const newCulture: cultureListInfo; list: Ptculture);
procedure AddGarden(const newgARDEN: TGarden; list: ptgarden);
function IsValidGarden(list: ptgarden; const str: string;
  var cod: integer): boolean;
function IsValidCulture(list: Ptculture; const str: string;
  var cod: integer): boolean;

implementation

procedure AddGarden(const newgARDEN: TGarden; list: ptgarden);
var
  firstNode: ptgarden;
begin
  firstNode := list.Next;

  new(list.Next);
  list.Next.garden := newgARDEN;
  list.Next.Next := firstNode;
end;

function IsValidGarden(list: ptgarden; const str: string;
  var cod: integer): boolean;
begin
  result := false;

  list := list.Next;
  while list <> nil do
  begin
    if list.garden.name = str then
    begin
      result := true;
      cod := list.garden.CodGarden;
      break;
    end;
    list := list.Next;
  end;
end;

function IsValidCulture(list: Ptculture; const str: string;
  var cod: integer): boolean;
begin
  result := false;

  list := list.Next;
  while list <> nil do
  begin
    if list.culture.name = str then
    begin
      result := true;
      cod := list.culture.cod;
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

function CheckCultureUsing(const culture: string): boolean;
begin
  result := false;
  for var I := 0 to _GardenX do
  begin
    for var J := 0 to _GardenY do
    begin
      if GardenMas[I][J].Сulture.name = culture then
      begin
        result := true;
      end;
    end;
  end;
end;

procedure DeleteCulture(const name: string; list: Ptculture);
begin
  while (list.Next <> nil) and (list.Next.culture.name <> name) do
  begin
    list := list.Next;
  end;
  if (list.Next <> nil) and (list.Next.culture.name = name) then
  begin
    list.Next := list.Next.Next;
  end;
end;

function CheckGardenUsing(const gardencod: integer): boolean;
begin
  result := false;
  for var I := 0 to _GardenX do
  begin
    for var J := 0 to _GardenY do
    begin
      if GardenMas[I][J].CodGarden = gardencod then
      begin
        result := true;
      end;
    end;
  end;
end;

procedure DeleteGarden(const name: string; list: ptgarden);
var
  index: integer;
begin
  index := GetIdGarden(name, list);
  // ShowMessage('Имя на удаление  : ' + name + ' индекс : ' + inttostr(index));

  while (list.Next <> nil) and (list.Next.garden.CodGarden <> index) do
  begin
    list := list.Next;
  end;

  if (list.Next <> nil) and (list.Next.garden.CodGarden = index) then
  begin
    list.Next := list.Next.Next;
    // ShowMessage('id : ' + inttostr(index) + '  color : ' +
    // ColorToString(dictionaryColorToId[index]));
    dictionaryColorToId.Remove(index);
  end;
end;

end.

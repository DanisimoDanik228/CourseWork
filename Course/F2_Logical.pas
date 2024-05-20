unit F2_Logical;

interface

uses
  ConstData, GLOBALdATA, SysUtils, Vcl.Dialogs, System.Generics.Collections,
  Graphics;

procedure ReadFileCulture(list: Ptculture);
procedure ReWriteFileGarden(list: PtGarden);
procedure RewriteFileCulture(list: Ptculture);
procedure ReadFileGarden(list: PtGarden);
function CheckCultureUsing(const culture: string): boolean;
procedure DeleteCulture(const name: string);
function CheckGardenUsing(const garden: string): boolean;
procedure DeleteGarden(const name: string);


implementation

procedure ReadFileCulture(list: Ptculture);
var
  currFile: file of cultureListInfo;

  count: integer;
begin
  count := 0;
  AssignFile(currFile, FileCulture);
  Reset(currFile);
  while not EoF(currFile) do
  begin;
    new(list^.Next);
    list := list^.Next;
    Read(currFile, list^.culture);
    if count < list^.culture.cod then
    begin
      count := list^.culture.cod;
    end;

  end;
  list^.Next := nil;

  currMaxIdCulture := count;
  Closefile(currFile);
end;

procedure ReadFileGarden(list: PtGarden);
var
  currFile: file of TGarden;

  count: integer;
begin
  count := 0;
  AssignFile(currFile, FileGarden);
  Reset(currFile);
  while not EoF(currFile) do
  begin
    new(list^.Next);
    list := list^.Next;
    Read(currFile, list^.garden);

    count := list^.garden.CodGarden;
  end;
  list^.Next := nil;

  Closefile(currFile);
end;

function CheckCultureUsing(const culture: string): boolean;
begin
  result := false;
  for var I := 0 to _GardenX do
  begin
    for var J := 0 to _GardenY do
    begin
      if GardenMas[I][J].�ulture.name = culture then
      begin
        result := true;
      end;
    end;
  end;
end;

procedure DeleteCulture(const name: string);
var
  list: Ptculture;
begin
  list := CultureList;
  while (list.Next <> nil) and (list.Next.culture.name <> name) do
  begin
    list := list.Next;
  end;
  if (list.Next <> nil) and (list.Next.culture.name = name) then
  begin
    list.Next := list.Next.Next;
  end;
end;

function CheckGardenUsing(const garden: string): boolean;
begin
  result := false;
  for var I := 0 to _GardenX do
  begin
    for var J := 0 to _GardenY do
    begin
      if GardenMas[I][J].CodGarden = GetIdGarden(garden) then
      begin
        result := true;
      end;
    end;
  end;
end;

procedure DeleteGarden(const name: string);
var
  list: PtGarden;
  index: integer;
begin
  index := GetIdGarden(name);
  ShowMessage('��� �� ��������  : ' + name + ' ������ : ' + inttostr(index));

  list := GardenList;
  while (list.Next <> nil) and (list.Next.garden.CodGarden <> index) do
  begin
    list := list.Next;
  end;

  if (list.Next <> nil) and (list.Next.garden.CodGarden = index) then
  begin
    list.Next := list.Next.Next;
    ShowMessage('id : ' + inttostr(index) + '  color : ' +
      ColorToString(dictionaryColorToId[index]));
    dictionaryColorToId.Remove(index);
  end;
end;

procedure RewriteFileCulture(list: Ptculture);
var
  currFile: file of cultureListInfo;
  count: integer;
begin
  AssignFile(currFile, FileCulture);
  Rewrite(currFile);
  count := 0;
  list := list.Next;
  while (list <> nil) do
  begin
    seek(currFile, count);
    write(currFile, list.culture);
    inc(count);
    list := list.Next;
  end;
  Closefile(currFile);
end;

procedure ReWriteFileGarden(list: PtGarden);
var
  currFile: file of TGarden;
  count: integer;
begin
  AssignFile(currFile, FileGarden);
  Rewrite(currFile);

  count := 0;
  list := list.Next;
  while (list <> nil) do
  begin
    seek(currFile, count);
    write(currFile, list.garden);
    inc(count);
    list := list.Next;
  end;
  Closefile(currFile);
end;

end.

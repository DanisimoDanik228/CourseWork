unit F1_Logical;

interface

uses
  globalData, constdata, Vcl.Graphics, MyDictionary;

procedure SaveFileGarden(list: PtGarden);
procedure ReadFileGarden(list: PtGarden);
// *
procedure ReadFileCulture(list: Ptculture);
procedure SaveFileCulture(list: Ptculture);
// *
procedure ReadFileColor;
procedure SaveFileColor;
// *
procedure SaveGardenMas;
procedure ReadGardenMas;
// *

// ONLY FOR DEVELOPERS
// {
procedure _CreateFirstFileGardenMas(culturelist: Ptculture);

procedure _CreateFirstFileCulture;

procedure _CreateFirstFileGarden;

procedure _CreateFirstFileColor;

// }
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

procedure SaveFileCulture(list: Ptculture);
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

procedure SaveFileGarden(list: PtGarden);
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

procedure _CreateFirstFileColor;
var
  currFile: file of RecordDictionary;
  countStr: integer;
  tempPair: RecordDictionary;
begin
  AssignFile(currFile, FileColor);
  Rewrite(currFile);

  seek(currFile, countStr);
  tempPair.Color := clred;
  tempPair.corGarden := 1;
  write(currFile, tempPair);
  inc(countStr);

  seek(currFile, countStr);

  tempPair.Color := clblue;
  tempPair.corGarden := 2;
  write(currFile, tempPair);
  inc(countStr);

  seek(currFile, countStr);
  tempPair.Color := clblack;
  tempPair.corGarden := 3;
  write(currFile, tempPair);
  inc(countStr);

  seek(currFile, countStr);
  tempPair.Color := clgreen;
  tempPair.corGarden := 4;
  write(currFile, tempPair);
  inc(countStr);

  Close(currFile);
end;

procedure _CreateFirstFileCulture;
  function CreateDate(const AYear, AMonth, ADays: integer): TMyDate;
  begin
    CreateDate.Year := AYear;
    CreateDate.Month := AMonth;
    CreateDate.Days := ADays;
  end;

var
  currFile: file of cultureListInfo;
  Str: cultureListInfo;
  countStr: integer;
begin
  countStr := 0;
  AssignFile(currFile, FileCulture);
  Rewrite(currFile);

  seek(currFile, countStr);
  Str.name := '��������';
  Str.cod := 1;
  Str.Time := CreateDate(1, 1, 1);
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '���������';
  Str.cod := 2;
  Str.Time := CreateDate(2, 2, 2);
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '�����';
  Str.cod := 3;
  Str.Time := CreateDate(3, 3, 3);
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '������';
  Str.cod := 4;
  Str.Time := CreateDate(4, 4, 4);
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '������';
  Str.cod := 5;
  Str.Time := CreateDate(5, 5, 5);
  write(currFile, Str);
  inc(countStr);

  Closefile(currFile);
end;

procedure _CreateFirstFileGarden;
var
  currFile: file of TGarden;
  Str: TGarden;
  countStr: integer;
begin
  countStr := 0;
  AssignFile(currFile, FileGarden);
  Rewrite(currFile);

  seek(currFile, countStr);
  Str.name := '������';
  Str.CodGarden := 1;
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '������';
  Str.CodGarden := 2;
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '������';
  Str.CodGarden := 3;
  write(currFile, Str);
  inc(countStr);

  seek(currFile, countStr);
  Str.name := '��������';
  Str.CodGarden := 4;
  write(currFile, Str);
  inc(countStr);

  Closefile(currFile);
end;

procedure SaveFileColor;
var
  currFile: file of RecordDictionary;

  count: integer;

  tempPair: RecordDictionary;
begin
  count := 0;

  AssignFile(currFile, FileColor);
  Rewrite(currFile);

  for var temp in dictionaryColorToId.GetAllItems do
  begin
    tempPair.corGarden := temp.Key;
    tempPair.Color := temp.Value;

    seek(currFile, count);
    write(currFile, tempPair);
    inc(count);
  end;

  Closefile(currFile);
end;

procedure SaveGardenMas;

var
  currFile: file of TGardenCell;
  count: integer;
begin
  AssignFile(currFile, UserFileGarden);
  Rewrite(currFile);

  count := 0;
  for var I := 0 to _GardenX do
  begin
    for var J := 0 to _GardenY do
    begin
      seek(currFile, count);
      write(currFile, GardenMas[I][J]);
      inc(count);
    end;
  end;

  Closefile(currFile);

end;

procedure _CreateFirstFileGardenMas(culturelist: Ptculture);
var
  GardenMas: TgardenMas;
  I, J: integer;
  currFile: file of TGardenCell;
  count: integer;
  Str: TGardenCell;

  list: Ptculture;
begin
  // *
  for I := 0 to 6 do
  begin
    for J := 0 to 4 do
    begin
      GardenMas[I][J].CodGarden := 1;
      GardenMas[I][J].�ulture.cod := 2;
      // GardenMas[I][J].�ulture.Name := 666;
    end;
  end;

  for I := 7 to 13 do
  begin
    for J := 0 to 7 do
    begin
      GardenMas[I][J].CodGarden := 2;
      GardenMas[I][J].�ulture.cod := 3;
      // GardenMas[I][J].�ulture := 666;
    end;
  end;

  for I := 14 to _GardenX do
  begin
    for J := 0 to _GardenY do
    begin
      GardenMas[I][J].CodGarden := 3;
      GardenMas[I][J].�ulture.cod := 4;
      // GardenMas[I][J].�ulture := 666;
    end;
  end;

  for I := 7 to 13 do
  begin
    for J := 6 to _GardenY do
    begin
      GardenMas[I][J].CodGarden := 4;
      GardenMas[I][J].�ulture.cod := 5;
      // GardenMas[I][J].�ulture := 666;
    end;
  end;

  for I := 0 to 6 do
  begin
    for J := 4 to _GardenY do
    begin
      GardenMas[I][J].CodGarden := 4;
      GardenMas[I][J].�ulture.cod := 1;
      // GardenMas[I][J].�ulture := 666;
    end;
  end;

  AssignFile(currFile, UserFileGarden);
  Rewrite(currFile);

  count := 0;
  for I := 0 to _GardenX do
  begin
    for J := 0 to _GardenY do
    begin
      seek(currFile, count);
      list := culturelist.Next;
      while list <> nil do
      begin
        if list.culture.cod = GardenMas[I][J].�ulture.cod then
        begin
          GardenMas[I][J].�ulture.name := list.culture.name;
          GardenMas[I][J].�ulture.Time := list.culture.Time;
          break;
        end;
        list := list.Next;
      end;
      write(currFile, GardenMas[I][J]);
      inc(count);
    end;
  end;

  Closefile(currFile);
end;

procedure ReadFileColor;
var
  currFile: file of RecordDictionary;
  tempPair: RecordDictionary;
begin
  AssignFile(currFile, FileColor);
  Reset(currFile);

  currMaxIdGarden := 0;

  while not EoF(currFile) do
  begin
    Read(currFile, tempPair);
    dictionaryColorToId.Add(tempPair.corGarden, tempPair.Color);

    if currMaxIdGarden < tempPair.corGarden then
    begin
      currMaxIdGarden := tempPair.corGarden;
    end;
  end;

  Close(currFile);
end;

procedure ReadGardenMas;
var
  currFile: file of TGardenCell;

  I, J: integer;
begin

  AssignFile(currFile, UserFileGarden);
  Reset(currFile);

  for I := 0 to _GardenX do
  begin
    for J := 0 to _GardenY do
    begin
      Read(currFile, GardenMas[I][J]);
    end;
  end;

  Closefile(currFile);

end;

end.

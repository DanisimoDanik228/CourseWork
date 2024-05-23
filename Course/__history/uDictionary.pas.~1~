unit MyDictionary;

interface

type
  TKeyValuePair<TKey, TValue> = record
    Key: TKey;
    Value: TValue;
  end;

  TMyDictionary<TKey, TValue> = class
  private
    FItems: array of TKeyValuePair<TKey, TValue>;
    function FindIndex(const Key: TKey): Integer;
  public
    procedure Add(const Key: TKey; const Value: TValue);
    function ContainsKey(const Key: TKey): Boolean;
    function ContainsValue(const Value: TValue): Boolean;
    function GetValue(const Key: TKey): TValue;
    procedure Remove(const Key: TKey);
    function Count: Integer;
     function GetAllItems: TArray<TKeyValuePair<TKey, TValue>>;
    property Items[const Key: TKey]: TValue read GetValue write Add; default;
  end;

implementation

{ TMyDictionary<TKey, TValue> }

procedure TMyDictionary<TKey, TValue>.Add(const Key: TKey; const Value: TValue);
var
  Index: Integer;
begin
  Index := FindIndex(Key);
  if Index >= 0 then
    FItems[Index].Value := Value
  else
  begin
    SetLength(FItems, Length(FItems) + 1);
    FItems[High(FItems)].Key := Key;
    FItems[High(FItems)].Value := Value;
  end;
end;

function TMyDictionary<TKey, TValue>.ContainsKey(const Key: TKey): Boolean;
begin
  Result := FindIndex(Key) >= 0;
end;

function TMyDictionary<TKey, TValue>.ContainsValue(const Value: TValue): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(FItems) do
    if FItems[I].Value = (Value) then
      Exit(True);
  Result := False;
end;

function TMyDictionary<TKey, TValue>.FindIndex(const Key: TKey): Integer;
var
  I: Integer;
begin
  for I := 0 to high(FItems) do
    if FItems[I].Key = (Key) then
      Exit(I);
  Result := -1;
end;
 function TMyDictionary<TKey, TValue>.GetAllItems: TArray<TKeyValuePair<TKey, TValue>>;
var
  I: Integer;
begin
  SetLength(Result, Length(FItems));
  for I := 0 to High(FItems) do
    Result[I] := FItems[I];
end;
function TMyDictionary<TKey, TValue>.GetValue(const Key: TKey): TValue;
var
  Index: Integer;
begin
  Index := FindIndex(Key);
  if Index >= 0 then
    Result := FItems[Index].Value
  else
   // raise Exception.CreateFmt('Key "%s" not found', [Key.ToString]);
end;

procedure TMyDictionary<TKey, TValue>.Remove(const Key: TKey);
var
  Index, I: Integer;
begin
  Index := FindIndex(Key);
  if Index >= 0 then
  begin
    for I := Index to High(FItems) - 1 do
      FItems[I] := FItems[I + 1];
    SetLength(FItems, Length(FItems) - 1);
  end;
end;

function TMyDictionary<TKey, TValue>.Count: Integer;
begin
  Result := Length(FItems);
end;

end.

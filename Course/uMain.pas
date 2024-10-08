unit uMain;

interface

uses
  uGarden,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, MMSystem, MPlayer,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  Math, uGlobalData, uConstData, uMain_Logical,
  System.ImageList, Vcl.ImgList, System.Actions, Vcl.ActnList, Vcl.Grids,
  Vcl.Menus, Vcl.ToolWin, Vcl.ComCtrls, uAddNewCulture, uAddNewGarden,
  uShowALLGardens, uDictionary, Messaging, uSP, uWorks;

type
  TForm1 = class(TForm)
    PaintBox1: TPaintBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    ToolBar1: TToolBar;
    ImageList1: TImageList;
    ToolButton1: TToolButton;
    ActionList: TActionList;
    ActionSave: TAction;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ActionPlus: TAction;
    ActionMinus: TAction;
    N8: TMenuItem;
    ActionShowAll: TAction;
    Label1: TLabel;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ActionShowSP: TAction;
    N2: TMenuItem;
    ShowSP1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ActionShowWork: TAction;
    procedure PaintRect(const x, y: integer; const color: Tcolor;
      const brush: Tcolor);
    procedure PaintBox1Paint(Sender: TObject);
    procedure ActionMinusExecute(Sender: TObject);
    procedure ActionPlusExecute(Sender: TObject);
    procedure PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
      x, y: integer);
    procedure PaintBox1Click(Sender: TObject);
    procedure PaintSelection(const Point: TPoint);
    procedure PaintSelectionCtrl(const Point: TPoint);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; x, y: integer);
    procedure ActionSaveExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ActionShowAllExecute(Sender: TObject);
    procedure ActionShowSPExecute(Sender: TObject);
    procedure ActionShowWorkExecute(Sender: TObject);
  private
    gardenlist: ptgarden;
    culturelist: ptculture;
    workslist: ptworks;

    IsLBM: boolean;

    ScaleGarden: integer;

    CurrPoint: TPoint;
    StartPoint: TPoint;

    StartPointPrintGarde: TPoint;

  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.PaintRect(const x, y: integer; const color: Tcolor;
  const brush: Tcolor);
var
  sizeRect: integer;

  Rect: TRect;
begin
  sizeRect := ScaleGarden;

  PaintBox1.Canvas.Pen.color := color;
  PaintBox1.Canvas.brush.color := color;

  Rect.CREATE(StartPointPrintGarde.x + x * sizeRect + PenSize,
    StartPointPrintGarde.y + y * sizeRect + PenSize, StartPointPrintGarde.x +
    (x + 1) * sizeRect, StartPointPrintGarde.y + (y + 1) * sizeRect);
  PaintBox1.Canvas.Rectangle(Rect);
end;

procedure TForm1.PaintSelection(const Point: TPoint);
var
  sizeRect: integer;

  Index_x1, Index_y1: integer;

  Rect: TRect;
begin
  sizeRect := ScaleGarden;
  Index_x1 := Point.x;
  Index_y1 := Point.y;

  if (Index_y1 >= 0) and (Index_x1 >= 0) then
    if (Index_y1 <= _GardenY) and (Index_x1 <= _GardenX) then
    begin
      PaintRect(Index_x1, Index_y1,
        IdentifyColor(GardenMas[Index_x1][Index_y1].CodGarden), clSilver);

      PaintBox1.Canvas.Pen.color :=
        NegativeColor(IdentifyColor(GardenMas[Index_x1][Index_y1].CodGarden));
      PaintBox1.Canvas.brush.color :=
        NegativeColor(IdentifyColor(GardenMas[Index_x1][Index_y1].CodGarden));

      Rect.CREATE(StartPointPrintGarde.x + Index_x1 * sizeRect + PenSize +
        sizeRect div 4, StartPointPrintGarde.y + Index_y1 * sizeRect + PenSize +
        sizeRect div 4, StartPointPrintGarde.x + (Index_x1 + 1) * sizeRect -
        sizeRect div 4, StartPointPrintGarde.y + (Index_y1 + 1) * sizeRect -
        sizeRect div 4);
      PaintBox1.Canvas.Rectangle(Rect);
    end;
end;

procedure TForm1.PaintSelectionCtrl(const Point: TPoint);
  procedure ClearPole(const IndexX, IndexY: integer);
  var
    i, j: integer;
  begin

    if IndexX <= _GardenX then
      for j := StartPoint.x to IndexX do
        for i := IndexY + 1 to _GardenY do
        begin
          PaintRect(j, i, (IdentifyColor(GardenMas[j][i].CodGarden)), clSilver);
        end;

    if IndexY <= _GardenY then
      for j := StartPoint.y to _GardenY do
        for i := IndexX + 1 to _GardenX do
        begin
          PaintRect(i, j, IdentifyColor(GardenMas[i][j].CodGarden), clSilver);
        end;
  end;

var
  Index_x1, Index_y1: integer;
  i, j: integer;

  Rect: TRect;

  sizeRect: integer;
begin
  Index_x1 := Point.x;
  Index_y1 := Point.y;

  if (Index_y1 >= 0) and (Index_x1 >= 0) then
    if (Index_y1 <= _GardenY) and (Index_x1 <= _GardenX) then
    begin
      for j := StartPoint.y to Index_y1 do
        for i := StartPoint.x to Index_x1 do
        begin
          // PaintRect(i, j, NegativeColor(IdentifyColor(GardenMas[i][j].CodGarden)
          // ), clWhite);
          sizeRect := ScaleGarden;

          PaintBox1.Canvas.Pen.color :=
            NegativeColor(IdentifyColor(GardenMas[i][j].CodGarden));
          PaintBox1.Canvas.brush.color :=
            NegativeColor(IdentifyColor(GardenMas[i][j].CodGarden));

          Rect.CREATE(StartPointPrintGarde.x + i * sizeRect + PenSize +
            sizeRect div 4, StartPointPrintGarde.y + j * sizeRect + PenSize +
            sizeRect div 4, StartPointPrintGarde.x + (i + 1) * sizeRect -
            sizeRect div 4, StartPointPrintGarde.y + (j + 1) * sizeRect -
            sizeRect div 4);
          PaintBox1.Canvas.Rectangle(Rect);
        end;
      ClearPole(Index_x1, Index_y1);
    end;
end;

procedure TForm1.ActionSaveExecute(Sender: TObject);
begin
  SaveGardenMas;

  SaveFileColor;

  saveFileGarden(gardenlist);

  saveFileCulture(culturelist);

  SaveFileworks(workslist);;

  MessageBox(Application.Handle, 'Сохранено успешно', 'Сохранение', MB_OK);
end;

procedure TForm1.ActionShowAllExecute(Sender: TObject);
begin
  Form5.FormShowAll(culturelist, gardenlist);
end;

procedure TForm1.ActionShowSPExecute(Sender: TObject);
begin
  uSP.Form6.MyShow;
end;

procedure TForm1.ActionShowWorkExecute(Sender: TObject);
begin

  Form7.MyShow(workslist);
end;

procedure TForm1.ActionMinusExecute(Sender: TObject);
begin

  if ScaleGarden > 15 then
  begin
    dec(ScaleGarden);
    Form1.PaintBox1.Invalidate;
    Form1.ActionPlus.Enabled := True;
    // Button_Plus.Enabled := true;
  end
  else
  begin
    Form1.ActionMinus.Enabled := True;
    // Button_Minus.Enabled := false;
  end;
end;

procedure TForm1.ActionPlusExecute(Sender: TObject);
begin
  if ScaleGarden < 70 then
  begin
    Form1.ActionMinus.Enabled := True;
    // Button_Minus.Enabled := true;
    inc(ScaleGarden);
    Form1.PaintBox1.Invalidate;
  end
  else
  begin
    Form1.ActionPlus.Enabled := True;
    // Button_Plus.Enabled := false;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  strTemp: string;
begin

  DoubleBuffered := True;


  new(gardenlist);
  new(culturelist);
  new(workslist);

  Form1.Caption := NameMainForm;

  IsLBM := false;

  CurrPoint.x := 0;
  CurrPoint.y := 0;
  StartPoint.x := -1;
  StartPoint.y := -1;

  StartPointPrintGarde.x := 0;
  StartPointPrintGarde.y := 0;

  PaintBox1.Canvas.CREATE;
  ScaleGarden := 70;

 // PaintBox1.Width := (1 + _GardenX) * (ScaleGarden + PenSize) + 10;
 // PaintBox1.Height := (1 + _GardenY) * (ScaleGarden + PenSize) + 10;

  dictionaryColorToId := TMyDictionary<integer, Tcolor>.CREATE;

  if 1 = 11 then
  begin
    _CreateFirstFileGarden;
    _CreateFirstFileCulture;
    _CreateFirstFileColor;

    readfileculture(culturelist);
    _CreateFirstFileGardenMas(culturelist);
  end;

  try
    ReadFileColor;

    ReadfileWorks(workslist);
    readGardenMas;
    readfileculture(culturelist);
    readfilegarden(gardenlist);
  except
    ShowMessage('ex : readfile');
  end;

 // ToolBar1.DoubleBuffered := False;
end;

procedure TForm1.PaintBox1Click(Sender: TObject);
begin
  if (StartPoint.x <> -1) and (StartPoint.y <> -1) then
  begin
    form2.createLists(culturelist, gardenlist);

    if (abs(StartPoint.x - CurrPoint.x) <> 0) or
      (abs(StartPoint.y - CurrPoint.y) <> 0) then
    begin
      if (StartPoint.x <= CurrPoint.x) and (StartPoint.y <= CurrPoint.y) then
        uGarden.form2.FormShowForChangeCtrl(CurrPoint, StartPoint);
    end
    else
    begin
      uGarden.form2.FormShowForChange(CurrPoint);
    end;

    IsLBM := false;

    Invalidate;

    StartPoint.x := -1;
    StartPoint.y := -1;

    CurrPoint.x := 0;
    CurrPoint.y := 0;
  end;
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; x, y: integer);
  var
  Rect : TRect;
begin
  if (StartPointPrintGarde.y < y) and (StartPointPrintGarde.x < x) then
    if (StartPointPrintGarde.x + (1 + _GardenX) * (ScaleGarden + PenSize) >= x)
      and (StartPointPrintGarde.y + (1 + _GardenY) * (ScaleGarden + PenSize)
      >= y) then
      if (Button = mbleft) then
      begin
        IsLBM := True;
        if (StartPoint.y = -1) or (StartPoint.x = -1) then
        begin
          StartPoint.x := (x - StartPointPrintGarde.x) div ScaleGarden;
          StartPoint.y := (y - StartPointPrintGarde.y) div ScaleGarden;
        end;
      end;
end;

procedure TForm1.PaintBox1MouseMove(Sender: TObject; Shift: TShiftState;
  x, y: integer);
var
  newPoint: TPoint;
begin

  if (StartPointPrintGarde.x + (1 + _GardenX) * (ScaleGarden) >= x) and
    (StartPointPrintGarde.y + (1 + _GardenY) * (ScaleGarden) >= y) and
    (StartPointPrintGarde.y < y) and (StartPointPrintGarde.x < x) then
  begin
    if (IsLBM) then
    begin
      CurrPoint.x := (x - StartPointPrintGarde.x) div ScaleGarden;
      CurrPoint.y := (y - StartPointPrintGarde.y) div ScaleGarden;

      if (CurrPoint.y <= _GardenY) and (CurrPoint.x <= _GardenX) then
        if (CurrPoint.y >= 0) and (CurrPoint.x >= 0) then
        begin
          PaintSelectionCtrl(CurrPoint);
        end;
    end
    else
    begin

      newPoint.x := (x - StartPointPrintGarde.x) div (ScaleGarden);
      newPoint.y := (y - StartPointPrintGarde.y) div (ScaleGarden);

      if (newPoint.x <> CurrPoint.x) or (newPoint.y <> CurrPoint.y) then
      begin
        if (CurrPoint.y <= _GardenY) and (CurrPoint.x <= _GardenX) then
          if (CurrPoint.y >= 0) and (CurrPoint.x >= 0) then
          begin
            PaintRect(CurrPoint.x, CurrPoint.y,
              IdentifyColor(GardenMas[CurrPoint.x][CurrPoint.y].CodGarden),
              clSilver);
          end;

        CurrPoint := newPoint;

        if (CurrPoint.y <= _GardenY) and (CurrPoint.x <= _GardenX) then
          if (CurrPoint.y >= 0) and (CurrPoint.x >= 0) then
          begin
            PaintSelection(CurrPoint);
          end;

      end;
    end;
  end
  else
  begin
    if (CurrPoint.y <= _GardenY) and (CurrPoint.x <= _GardenX) then
      if (CurrPoint.y >= 0) and (CurrPoint.x >= 0) then
        if not IsLBM then
        begin
          PaintRect(CurrPoint.x, CurrPoint.y,
            IdentifyColor(GardenMas[CurrPoint.x][CurrPoint.y].CodGarden),
            clSilver);
        end;

    CurrPoint.x := -1;
    CurrPoint.y := -1;
  end;
end;

procedure TForm1.PaintBox1Paint(Sender: TObject);
begin
  PaintBox1.Canvas.brush.color := clBtnFace;
  PaintBox1.Canvas.FillRect(PaintBox1.ClientRect);

  StartPointPrintGarde.x :=
    (PaintBox1.Width - _GardenX * (ScaleGarden + PenSize)) div 2 + 5;
  StartPointPrintGarde.y :=
    (PaintBox1.Height - _GardenY * (ScaleGarden + PenSize)) div 2 - 5;

  for var i := 0 to _GardenX do
  begin
    for var j := 0 to _GardenY do
    begin
      PaintRect(i, j, IdentifyColor(GardenMas[i][j].CodGarden), clSilver);
    end;
  end;

end;

end.

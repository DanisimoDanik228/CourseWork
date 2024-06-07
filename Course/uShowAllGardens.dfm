object Form5: TForm5
  Left = 565
  Top = 295
  BorderStyle = bsDialog
  Caption = #1042#1072#1096' '#1057#1072#1076
  ClientHeight = 410
  ClientWidth = 697
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnCreate = FormCreate
  OnShow = FormShow
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 101
    Height = 23
    Caption = #1042#1072#1096#1080' '#1075#1088#1103#1076#1082#1080
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 536
    Top = 8
    Width = 150
    Height = 23
    Caption = #1042#1089#1077' '#1074#1072#1096#1080' '#1082#1091#1083#1100#1090#1091#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 264
    Top = 8
    Width = 249
    Height = 23
    Caption = #1050#1091#1083#1100#1090#1091#1088#1099' '#1085#1072' '#1074#1099#1073#1088#1072#1085#1085#1086#1081' '#1075#1088#1103#1076#1082#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ListViewGarden: TListView
    Left = 8
    Top = 40
    Width = 250
    Height = 150
    Color = cl3DLight
    Columns = <>
    Ctl3D = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnClick = ListViewGardenClick
  end
  object Button1: TButton
    Left = 128
    Top = 9
    Width = 123
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1074#1089#1077' '#1075#1088#1103#1076#1082#1080
    TabOrder = 1
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 8
    Top = 196
    Width = 369
    Height = 209
    Caption = 'Panel1'
    Color = clCream
    ParentBackground = False
    TabOrder = 2
    DesignSize = (
      369
      209)
    object PaintBox1: TPaintBox
      Left = 46
      Top = 32
      Width = 347
      Height = 201
      Anchors = [akTop, akRight]
      OnMouseDown = PaintBox1MouseDown
      OnPaint = PaintBox1Paint
    end
  end
  object ListViewCulture: TListView
    Left = 264
    Top = 37
    Width = 138
    Height = 153
    Color = cl3DLight
    Columns = <>
    Ctl3D = False
    ReadOnly = True
    RowSelect = True
    TabOrder = 3
    ViewStyle = vsReport
  end
  object ListViewCultureAll: TListView
    Left = 536
    Top = 37
    Width = 113
    Height = 150
    Color = cl3DLight
    Columns = <>
    ReadOnly = True
    TabOrder = 4
    ViewStyle = vsReport
    OnClick = ListViewCultureAllClick
  end
end

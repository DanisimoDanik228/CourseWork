object Form3: TForm3
  Left = 242
  Top = 507
  BorderStyle = bsDialog
  ClientHeight = 161
  ClientWidth = 538
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesigned
  OnClose = FormClose
  TextHeight = 15
  object Label1: TLabel
    Left = 88
    Top = 8
    Width = 365
    Height = 31
    Caption = #1044#1086#1073#1072#1074#1083#1077#1085#1080#1077' '#1085#1086#1074#1086#1075#1086' '#1074#1080#1076#1072' '#1082#1091#1083#1100#1090#1091#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -23
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 56
    Width = 152
    Height = 23
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1091#1083#1100#1090#1091#1088#1099
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 112
    Width = 171
    Height = 23
    Caption = #1042#1088#1077#1084#1103' '#1085#1072' '#1089#1086#1079#1088#1077#1074#1072#1085#1080#1077
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object ButtonCancel: TButton
    Left = 423
    Top = 70
    Width = 93
    Height = 33
    Caption = #1054#1090#1084#1077#1085#1072
    DisabledImageName = 'ButtonClose'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = ButtonCancelClick
  end
  object EditName: TEdit
    Left = 190
    Top = 56
    Width = 155
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    TextHint = #1085#1072#1079#1074#1072#1085#1080#1077
  end
  object ButtonSave: TButton
    Left = 423
    Top = 109
    Width = 93
    Height = 33
    Caption = #1054#1082
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = ButtonSaveClick
  end
  object EditTime: TEdit
    Left = 190
    Top = 112
    Width = 155
    Height = 31
    Hint = #1060#1086#1088#1084#1072#1090' '#1074#1074#1086#1076#1072' '#1076#1076':'#1084#1084':'#1075
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TextHint = 'dd:mm:y'
  end
end

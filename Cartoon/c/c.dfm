object Form1: TForm1
  Left = 0
  Top = 0
  Align = alClient
  Caption = 'Form1'
  ClientHeight = 872
  ClientWidth = 1434
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnPaint = FormPaint
  TextHeight = 15
  object Button1: TButton
    Left = 8
    Top = 728
    Width = 201
    Height = 113
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 1016
    Top = 736
    Width = 281
    Height = 97
    Caption = 'Button2'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Timer1: TTimer
    OnTimer = Timer1Timer
    Left = 768
    Top = 120
  end
end

object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 212
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 418
    Height = 171
    Align = alClient
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 418
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitLeft = 128
    ExplicitTop = 104
    ExplicitWidth = 185
    object Button1: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = '&Append'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object SQLiteClientDataSet1: TSQLiteClientDataSet
    Params = <>
    Left = 64
    Top = 48
    object SQLiteClientDataSet1CODI: TIntegerField
      FieldName = 'CODI'
    end
    object SQLiteClientDataSet1NOME: TStringField
      FieldName = 'NOME'
      Size = 30
    end
  end
  object DataSource1: TDataSource
    DataSet = SQLiteClientDataSet1
    Left = 200
    Top = 112
  end
end

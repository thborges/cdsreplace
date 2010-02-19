object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 356
  ClientWidth = 634
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 229
    Width = 634
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 41
    ExplicitWidth = 191
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 634
    Height = 188
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
    Width = 634
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object btnCDS: TButton
      Left = 8
      Top = 10
      Width = 97
      Height = 25
      Caption = 'Client DataSet'
      TabOrder = 0
      OnClick = btnCDSClick
    end
    object btnSiagri: TButton
      Left = 111
      Top = 10
      Width = 97
      Height = 25
      Caption = 'Siagri DataSet'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnSiagriClick
    end
  end
  object DBGrid2: TDBGrid
    Left = 0
    Top = 232
    Width = 634
    Height = 124
    Align = alBottom
    DataSource = DataSource3
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      
        'Database=localhost:C:\Users\Thiago\Desktop\Sources\FUTURA_OLD.FD' +
        'B'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    VendorLib = 'fbclient.dll'
    Left = 40
    Top = 80
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'select first 10 * from TRANSAC')
    SQLConnection = SQLConnection1
    Left = 40
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 368
    Top = 136
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLQuery1
    Left = 352
    Top = 24
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 440
    Top = 24
  end
  object SQLQuery2: TSQLQuery
    DataSource = DataSource2
    MaxBlobSize = 1
    Params = <
      item
        DataType = ftInteger
        Name = 'CODI_TRA'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from NOTA'
      'where CODI_TRA = :CODI_TRA')
    SQLConnection = SQLConnection1
    Left = 40
    Top = 200
  end
  object DataSource2: TDataSource
    DataSet = SQLQuery1
    Left = 120
    Top = 136
  end
  object ClientDataSet2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 440
    Top = 80
  end
  object DataSource3: TDataSource
    DataSet = ClientDataSet2
    Left = 448
    Top = 136
  end
  object SQLiteClientDataSet1: TSQLiteClientDataSet
    Params = <>
    DataSetProvider = SQLiteDataSetProvider1
    Left = 296
    Top = 184
  end
  object SQLiteClientDataSet2: TSQLiteClientDataSet
    Params = <>
    Left = 296
    Top = 240
  end
  object SQLiteDataSetProvider1: TSQLiteDataSetProvider
    DataSet = SQLQuery1
    Left = 248
    Top = 136
  end
end

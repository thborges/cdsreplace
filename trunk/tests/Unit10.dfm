object Form10: TForm10
  Left = 0
  Top = 0
  BorderWidth = 5
  Caption = 'Form10'
  ClientHeight = 244
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 36
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Button1: TButton
      Left = 0
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Client'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 81
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Siagri'
      TabOrder = 1
      OnClick = Button2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 36
    Width = 470
    Height = 208
    Align = alClient
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select'
      
        '  M.DEMI_NOT as DEMI, M.CODI_EMP, M.CODI_IND, M.DATA_VLR, TP.CMN' +
        'O_TOP, FT.FUNC_TOP,'
      
        '  M.CODI_TRA, CL.CODI_CTC, PS.CODI_PSV, PS.UNID_PSV, M.COD1_PES,' +
        ' M.COD2_PES, FR.CODI_TRA as CODI_FOR,'
      
        '  PS.CODI_GPR, PS.CODI_SBG, PS.CODI_TIP, FRC.CODI_CTF, PR.CEST_P' +
        'RO, PR.QTE1_PRO,'
      
        '  PR.QTE2_PRO, I.QTDE_INO, I.VLIQ_INO, (I.QTDE_INO * I.VLIQ_INO)' +
        ' as ValorTotal,'
      
        '  ((I.QTDE_INO * I.VLIQ_INO) - (I.QTDE_INO * I.VLOR_INO) - I.VIP' +
        'I_INO) as DESPESAS,'
      
        '  (I.QTDE_INO * I.CMVD_INO) as CMVD_INO, (I.QTDE_INO * I.CTAB_IN' +
        'O) as CTAB_INO,'
      
        '  (I.QTDE_INO * I.PVTB_INO) as PVTB, I.CODI_CUL, I.PIS_INO PIS, ' +
        'I.COFI_INO COFINS,'
      
        '  I.VICM_INO ICMS, (I.QTDE_INO * I.CGFI_INO) as CGFI, (I.QTDE_IN' +
        'O * I.CCPD_INO) as CCPD_INO,'
      
        '  TP.PNFO_TOP, cast('#39'NE'#39' as CHAR(2)) as TIPO_DOC, M.CODI_CIC, M.' +
        'COND_CON, M.CODI_TRA as TRAO,'
      
        '  M.NPRE_NOT as NOTO, M.SERI_NOT as SERO, (Cast(M.NOTA_NOT as va' +
        'rchar(10)) || '#39'\'#39' || M.SERI_NOT) as DOC_SERIE, I.ITEM_INO as ITE' +
        'O, VC.COD1_PES as CCODI_PES, VC.COD2_PES AS CCOD2_PES,'
      '  case'
      '     when M.PROP_PRO is not null then'
      '        PD.CODI_REG'
      '     else'
      '        CL.CODI_REG'
      '  end'
      '  as CODI_REG,'
      '  case'
      '     when M.PROP_PRO is not null then'
      '        PD.CODI_ROT'
      '     else'
      '        CL.CODI_ROT'
      '  end'
      '  as CODI_ROT,'
      '  case'
      '     when M.PROP_PRO is not null then'
      '        PD.CODI_MUN'
      '     else'
      '        TR.CODI_MUN'
      '  end'
      '  as CODI_MUN,'
      '  case'
      '     when M.PROP_PRO is not null then'
      '        M2.ESTA_MUN'
      '     else'
      '        M1.ESTA_MUN'
      '  end'
      '  as ESTA_MUN,'
      '  M.CCFO_CFO,'
      '  M.CODI_TOP,'
      '  C.COMP_CFO,'
      '  I.TABE_CTA,'
      '  (select first 1 Dpon_rec'
      '     from NOTACRC CRC'
      '     inner join CABREC cab on (CRC.ctrl_cbr = CAB.ctrl_cbr)'
      '     inner join receber rec on (CAB.CTRL_CBR = REC.CTRL_CBR)'
      '     where crc.codi_emp = m.codi_emp'
      '       and crc.tdoc_noc = '#39'NE'#39
      '       and crc.ndoc_noc = m.nota_not'
      '       and crc.sdoc_noc = m.seri_not) as desconto,'
      '  T.TCUS_TAB,'
      '  (I.QTDE_INO * I.VLIQ_INO)*   /*COMISS'#195'O POR VENDEDOR 1*/'
      '  (SELECT SUM(comi_pin) / 100'
      '     FROM PINOTA pip'
      '     WHERE pip.NPRE_NOT = m.NPRE_NOT'
      '      AND pip.ITEM_INO = i.ITEM_INO'
      '      AND pip.CODI_PES = m.COD1_PES'
      '  ) AS COMISSAO_VEND1,'
      '  (I.QTDE_INO * I.VLIQ_INO)*   /*COMISS'#195'O POR VENDEDOR 2*/'
      '  (SELECT SUM(comi_pin) / 100'
      '     FROM PINOTA pip'
      '     WHERE pip.NPRE_NOT = m.NPRE_NOT'
      '      AND pip.ITEM_INO = i.ITEM_INO'
      '      and pip.CODI_PES = m.COD2_PES'
      '  ) AS COMISSAO_VEND2,'
      '  (I.QTDE_INO * I.VLIQ_INO)*   /*COMISS'#195'O TOTAL*/'
      '  (SELECT SUM(comi_pin) / 100'
      '     FROM PINOTA pip'
      '     WHERE pip.NPRE_NOT = m.NPRE_NOT'
      '      AND pip.ITEM_INO = i.ITEM_INO) AS COMISSAO_TOTAL'
      ''
      'from INOTA I'
      'inner join NOTA M on (M.NPRE_NOT = I.NPRE_NOT)'
      
        'inner join FUNCAOTOPER FT on (FT.CODI_TOP = M.CODI_TOP and FT.CO' +
        'DI_PTO = 102)'
      'inner join CFO C on (C.CCFO_CFO = M.CCFO_CFO)'
      'left join TIPOOPER TP on (TP.CODI_TOP = M.CODI_TOP)'
      
        'left join PEDIDO P on (P.CODI_EMP = M.CODI_EMP and P.PEDI_PED = ' +
        'M.PEDI_PED and P.SERI_PED = M.SERI_PED)'
      'left join CLIENTE CL on (M.CODI_TRA = CL.CODI_TRA)'
      
        'left join VENDEDORCLI VC on (VC.CODI_TRA = M.CODI_TRA and VC.COD' +
        'I_EMP = M.CODI_EMP)'
      'left join PROPRIED PD on (M.PROP_PRO = PD.PROP_PRO)'
      'left join MUNICIPIO M2 on (M2.CODI_MUN = PD.CODI_MUN)'
      'left join TRANSAC TR on (M.CODI_TRA = TR.CODI_TRA)'
      'left join MUNICIPIO M1 on (M1.CODI_MUN = TR.CODI_MUN)'
      'left join PRODSERV PS on (I.CODI_PSV = PS.CODI_PSV)'
      'left join PRODUTO PR on (PS.CODI_PSV = PR.CODI_PSV)'
      'left join TRANSAC FR on (FR.CODI_TRA = PR.CODI_TRA)'
      'left join FORNEC FRC on (FR.CODI_TRA = FRC.CODI_TRA)'
      
        'left join TABELA T on (T.TABE_CTA = I.TABE_CTA and T.CODI_PSV = ' +
        'I.CODI_PSV)'
      'left join VENDEDOR VD on (VD.CODI_PES = M.COD1_PES)'
      
        '-- where (M.DEMI_NOT between '#39'01/01/2009'#39' and '#39'12/31/2009'#39') and ' +
        '(M.SITU_NOT = '#39'5'#39')  and (M.CODI_EMP in ('#39'1'#39','#39'3'#39'))')
    SQLConnection = SQLConnection2
    Left = 136
    Top = 64
  end
  object DataSetProvider1: TDataSetProvider
    DataSet = SQLQuery1
    Left = 184
    Top = 96
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 248
    Top = 128
  end
  object SQLConnection2: TSQLConnection
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
  object SQLiteDataSetProvider1: TSQLiteDataSetProvider
    Left = 168
    Top = 192
  end
  object SQLiteClientDataSet1: TSQLiteClientDataSet
    Params = <>
    Left = 272
    Top = 200
  end
end

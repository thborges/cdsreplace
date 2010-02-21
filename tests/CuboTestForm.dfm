object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 451
  ClientWidth = 463
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 344
    Top = 48
    Width = 75
    Height = 25
    Caption = 'Client'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 344
    Top = 79
    Width = 75
    Height = 25
    Caption = 'Sqlite'
    TabOrder = 1
    OnClick = Button2Click
  end
  object clbEntidades: TCheckListBox
    Left = 2
    Top = 5
    Width = 231
    Height = 415
    BorderStyle = bsNone
    Items.Strings = (
      'Empresas'
      'Vendedor 1'
      'Vendedor 2'
      'Clientes'
      'Categorias de Cliente'
      'Materiais'
      'Grupos/SugGrupos de Material'
      'Tipos de Material'
      'Fabricantes'
      'Categorias de Fabricante'
      'Culturas'
      'Regi'#245'es'
      'Munic'#237'pios'
      'Estados'
      'Rotas'
      'Ciclo de Produ'#231#227'o'
      'Condi'#231#227'o de Pagamento'
      'Ano'
      'Semestre'
      'Quadrimestre'
      'Bimestre'
      'Trimestre'
      'M'#234's'
      'Dia'
      'CFOP'
      'Tipo de Opera'#231#227'o'
      'Documento/S'#233'rie')
    Style = lbOwnerDrawFixed
    TabOrder = 2
  end
  object ProgressBar: TProgressBar
    Left = 8
    Top = 426
    Width = 447
    Height = 17
    Step = 1
    TabOrder = 3
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
    Connected = True
    Left = 40
    Top = 80
  end
  object SQLQuery1: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select first 100'
      '  EMP.CODI_EMP,'
      
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
      'left join CADEMP EMP on (1=0)'
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
  object cdsVendas: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    Left = 248
    Top = 128
    object cdsVendasCODI_EMP: TSmallintField
      FieldName = 'CODI_EMP'
    end
    object cdsVendasDEMI: TDateField
      FieldName = 'DEMI'
    end
    object cdsVendasCODI_IND: TIntegerField
      FieldName = 'CODI_IND'
    end
    object cdsVendasDATA_VLR: TDateField
      FieldName = 'DATA_VLR'
    end
    object cdsVendasFUNC_TOP: TStringField
      FieldName = 'FUNC_TOP'
      Required = True
      FixedChar = True
      Size = 1
    end
    object cdsVendasCODI_TRA: TIntegerField
      FieldName = 'CODI_TRA'
      Required = True
    end
    object cdsVendasCODI_CTC: TIntegerField
      FieldName = 'CODI_CTC'
    end
    object cdsVendasCODI_PSV: TStringField
      FieldName = 'CODI_PSV'
      Size = 15
    end
    object cdsVendasCODI_FOR: TIntegerField
      FieldName = 'CODI_FOR'
    end
    object cdsVendasCODI_GPR: TIntegerField
      FieldName = 'CODI_GPR'
    end
    object cdsVendasCODI_SBG: TIntegerField
      FieldName = 'CODI_SBG'
    end
    object cdsVendasCODI_TIP: TIntegerField
      FieldName = 'CODI_TIP'
    end
    object cdsVendasCODI_CTF: TIntegerField
      FieldName = 'CODI_CTF'
    end
    object cdsVendasCEST_PRO: TStringField
      FieldName = 'CEST_PRO'
      FixedChar = True
      Size = 1
    end
    object cdsVendasQTE1_PRO: TFloatField
      FieldName = 'QTE1_PRO'
    end
    object cdsVendasQTE2_PRO: TFloatField
      FieldName = 'QTE2_PRO'
    end
    object cdsVendasQTDE_INO: TFloatField
      FieldName = 'QTDE_INO'
    end
    object cdsVendasCOD1_PES: TIntegerField
      FieldName = 'COD1_PES'
    end
    object cdsVendasCMVD_INO: TFloatField
      FieldName = 'CMVD_INO'
    end
    object cdsVendasCTAB_INO: TFloatField
      FieldName = 'CTAB_INO'
    end
    object cdsVendasVALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
    object cdsVendasPVTB: TFloatField
      FieldName = 'PVTB'
    end
    object cdsVendasCODI_CUL: TFloatField
      FieldName = 'CODI_CUL'
    end
    object cdsVendasPIS: TFloatField
      FieldName = 'PIS'
    end
    object cdsVendasCOFINS: TFloatField
      FieldName = 'COFINS'
    end
    object cdsVendasICMS: TFloatField
      FieldName = 'ICMS'
    end
    object cdsVendasCGFI: TFloatField
      FieldName = 'CGFI'
    end
    object cdsVendasCODI_REG: TIntegerField
      FieldName = 'CODI_REG'
    end
    object cdsVendasCODI_ROT: TIntegerField
      FieldName = 'CODI_ROT'
    end
    object cdsVendasCODI_MUN: TIntegerField
      FieldName = 'CODI_MUN'
    end
    object cdsVendasESTA_MUN: TStringField
      FieldName = 'ESTA_MUN'
      FixedChar = True
      Size = 2
    end
    object cdsVendasPNFO_TOP: TStringField
      FieldName = 'PNFO_TOP'
      FixedChar = True
      Size = 1
    end
    object cdsVendasTIPO_DOC: TStringField
      FieldName = 'TIPO_DOC'
      Required = True
      FixedChar = True
      Size = 2
    end
    object cdsVendasTRAO: TIntegerField
      FieldName = 'TRAO'
      Required = True
    end
    object cdsVendasNOTO: TIntegerField
      FieldName = 'NOTO'
      Required = True
    end
    object cdsVendasSERO: TStringField
      FieldName = 'SERO'
      Size = 3
    end
    object cdsVendasITEO: TIntegerField
      FieldName = 'ITEO'
      Required = True
    end
    object cdsVendasCODI_CIC: TIntegerField
      FieldName = 'CODI_CIC'
    end
    object cdsVendasCOND_CON: TIntegerField
      FieldName = 'COND_CON'
    end
    object cdsVendasCMNO_TOP: TStringField
      FieldName = 'CMNO_TOP'
      FixedChar = True
      Size = 1
    end
    object cdsVendasCCFO_CFO: TStringField
      FieldName = 'CCFO_CFO'
      Size = 6
    end
    object cdsVendasCODI_TOP: TIntegerField
      FieldName = 'CODI_TOP'
    end
    object cdsVendasCCPD_INO: TFloatField
      FieldName = 'CCPD_INO'
    end
    object cdsVendasCCODI_PES: TIntegerField
      FieldName = 'CCODI_PES'
    end
    object cdsVendasCOMP_CFO: TStringField
      FieldName = 'COMP_CFO'
      FixedChar = True
      Size = 1
    end
    object cdsVendasUNID_PSV: TStringField
      FieldName = 'UNID_PSV'
      Size = 3
    end
    object cdsVendasVLIQ_INO: TFloatField
      FieldName = 'VLIQ_INO'
    end
    object cdsVendasTABE_CTA: TIntegerField
      FieldName = 'TABE_CTA'
    end
    object cdsVendasCCOD2_PES: TIntegerField
      FieldName = 'CCOD2_PES'
    end
    object cdsVendasCOD2_PES: TIntegerField
      FieldName = 'COD2_PES'
    end
    object cdsVendasCOMISSAO_VEND1: TFloatField
      FieldName = 'COMISSAO_VEND1'
    end
    object cdsVendasCOMISSAO_VEND2: TFloatField
      FieldName = 'COMISSAO_VEND2'
    end
    object cdsVendasCOMISSAO_TOTAL: TFloatField
      FieldName = 'COMISSAO_TOTAL'
    end
    object cdsVendasTCUS_TAB: TStringField
      FieldName = 'TCUS_TAB'
      Size = 1
    end
    object cdsVendasDOC_SERIE: TStringField
      FieldName = 'DOC_SERIE'
      Size = 15
    end
    object cdsVendasDESCONTO: TFloatField
      FieldName = 'DESCONTO'
    end
    object cdsVendasDESPESAS: TFloatField
      FieldName = 'DESPESAS'
    end
  end
  object SQLiteDataSetProvider1: TSQLiteDataSetProvider
    DataSet = SQLQuery1
    Left = 168
    Top = 192
  end
  object sqcVendas: TSQLiteClientDataSet
    Params = <>
    DataSetProvider = SQLiteDataSetProvider1
    Left = 272
    Top = 200
    object sqcVendasCODI_EMP: TSmallintField
      FieldName = 'CODI_EMP'
    end
    object sqcVendasDEMI: TDateField
      FieldName = 'DEMI'
    end
    object sqcVendasCODI_IND: TIntegerField
      FieldName = 'CODI_IND'
    end
    object sqcVendasDATA_VLR: TDateField
      FieldName = 'DATA_VLR'
    end
    object sqcVendasCMNO_TOP: TStringField
      FieldName = 'CMNO_TOP'
      FixedChar = True
      Size = 1
    end
    object sqcVendasFUNC_TOP: TStringField
      FieldName = 'FUNC_TOP'
      Required = True
      FixedChar = True
      Size = 1
    end
    object sqcVendasCODI_TRA: TIntegerField
      FieldName = 'CODI_TRA'
      Required = True
    end
    object sqcVendasCODI_CTC: TIntegerField
      FieldName = 'CODI_CTC'
    end
    object sqcVendasCODI_PSV: TStringField
      FieldName = 'CODI_PSV'
      Size = 15
    end
    object sqcVendasUNID_PSV: TStringField
      FieldName = 'UNID_PSV'
      Size = 3
    end
    object sqcVendasCOD1_PES: TIntegerField
      FieldName = 'COD1_PES'
    end
    object sqcVendasCOD2_PES: TIntegerField
      FieldName = 'COD2_PES'
    end
    object sqcVendasCODI_FOR: TIntegerField
      FieldName = 'CODI_FOR'
    end
    object sqcVendasCODI_GPR: TIntegerField
      FieldName = 'CODI_GPR'
    end
    object sqcVendasCODI_SBG: TIntegerField
      FieldName = 'CODI_SBG'
    end
    object sqcVendasCODI_TIP: TIntegerField
      FieldName = 'CODI_TIP'
    end
    object sqcVendasCODI_CTF: TIntegerField
      FieldName = 'CODI_CTF'
    end
    object sqcVendasCEST_PRO: TStringField
      FieldName = 'CEST_PRO'
      FixedChar = True
      Size = 1
    end
    object sqcVendasQTE1_PRO: TFloatField
      FieldName = 'QTE1_PRO'
    end
    object sqcVendasQTE2_PRO: TFloatField
      FieldName = 'QTE2_PRO'
    end
    object sqcVendasQTDE_INO: TFloatField
      FieldName = 'QTDE_INO'
    end
    object sqcVendasVLIQ_INO: TFloatField
      FieldName = 'VLIQ_INO'
    end
    object sqcVendasVALORTOTAL: TFloatField
      FieldName = 'VALORTOTAL'
    end
    object sqcVendasDESPESAS: TFloatField
      FieldName = 'DESPESAS'
    end
    object sqcVendasCMVD_INO: TFloatField
      FieldName = 'CMVD_INO'
    end
    object sqcVendasCTAB_INO: TFloatField
      FieldName = 'CTAB_INO'
    end
    object sqcVendasPVTB: TFloatField
      FieldName = 'PVTB'
    end
    object sqcVendasCODI_CUL: TFloatField
      FieldName = 'CODI_CUL'
    end
    object sqcVendasPIS: TFloatField
      FieldName = 'PIS'
    end
    object sqcVendasCOFINS: TFloatField
      FieldName = 'COFINS'
    end
    object sqcVendasICMS: TFloatField
      FieldName = 'ICMS'
    end
    object sqcVendasCGFI: TFloatField
      FieldName = 'CGFI'
    end
    object sqcVendasCCPD_INO: TFloatField
      FieldName = 'CCPD_INO'
    end
    object sqcVendasPNFO_TOP: TStringField
      FieldName = 'PNFO_TOP'
      FixedChar = True
      Size = 1
    end
    object sqcVendasTIPO_DOC: TStringField
      FieldName = 'TIPO_DOC'
      Required = True
      FixedChar = True
      Size = 2
    end
    object sqcVendasCODI_CIC: TIntegerField
      FieldName = 'CODI_CIC'
    end
    object sqcVendasCOND_CON: TIntegerField
      FieldName = 'COND_CON'
    end
    object sqcVendasTRAO: TIntegerField
      FieldName = 'TRAO'
      Required = True
    end
    object sqcVendasNOTO: TIntegerField
      FieldName = 'NOTO'
      Required = True
    end
    object sqcVendasSERO: TStringField
      FieldName = 'SERO'
      Size = 3
    end
    object sqcVendasDOC_SERIE: TStringField
      FieldName = 'DOC_SERIE'
      Size = 14
    end
    object sqcVendasITEO: TIntegerField
      FieldName = 'ITEO'
      Required = True
    end
    object sqcVendasCCODI_PES: TIntegerField
      FieldName = 'CCODI_PES'
    end
    object sqcVendasCCOD2_PES: TIntegerField
      FieldName = 'CCOD2_PES'
    end
    object sqcVendasCODI_REG: TIntegerField
      FieldName = 'CODI_REG'
    end
    object sqcVendasCODI_ROT: TIntegerField
      FieldName = 'CODI_ROT'
    end
    object sqcVendasCODI_MUN: TIntegerField
      FieldName = 'CODI_MUN'
    end
    object sqcVendasESTA_MUN: TStringField
      FieldName = 'ESTA_MUN'
      FixedChar = True
      Size = 2
    end
    object sqcVendasCCFO_CFO: TStringField
      FieldName = 'CCFO_CFO'
      Required = True
      Size = 6
    end
    object sqcVendasCODI_TOP: TIntegerField
      FieldName = 'CODI_TOP'
      Required = True
    end
    object sqcVendasCOMP_CFO: TStringField
      FieldName = 'COMP_CFO'
      FixedChar = True
      Size = 1
    end
    object sqcVendasTABE_CTA: TIntegerField
      FieldName = 'TABE_CTA'
    end
    object sqcVendasDESCONTO: TFloatField
      FieldName = 'DESCONTO'
    end
    object sqcVendasTCUS_TAB: TStringField
      FieldName = 'TCUS_TAB'
      FixedChar = True
      Size = 1
    end
    object sqcVendasCOMISSAO_VEND1: TFloatField
      FieldName = 'COMISSAO_VEND1'
    end
    object sqcVendasCOMISSAO_VEND2: TFloatField
      FieldName = 'COMISSAO_VEND2'
    end
    object sqcVendasCOMISSAO_TOTAL: TFloatField
      FieldName = 'COMISSAO_TOTAL'
    end
  end
  object cdsTemp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 240
    Top = 48
    object cdsTempQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object cdsTempUNID_PSV: TStringField
      FieldName = 'UNID_PSV'
      Size = 3
    end
    object cdsTempCODI_EMP: TSmallintField
      FieldName = 'CODI_EMP'
    end
    object cdsTempCODI_PES: TIntegerField
      FieldName = 'CODI_PES'
    end
    object cdsTempCODI_PSV: TStringField
      FieldName = 'CODI_PSV'
      Size = 15
    end
    object cdsTempDEMI: TDateField
      FieldName = 'DEMI'
    end
    object cdsTempCODI_TRA: TIntegerField
      FieldName = 'CODI_TRA'
    end
    object cdsTempCODI_FOR: TIntegerField
      FieldName = 'CODI_FOR'
    end
    object cdsTempCODI_GPR: TIntegerField
      FieldName = 'CODI_GPR'
    end
    object cdsTempCODI_SBG: TStringField
      FieldName = 'CODI_SBG'
    end
    object cdsTempCODI_TIP: TIntegerField
      FieldName = 'CODI_TIP'
    end
    object cdsTempCODI_CTF: TIntegerField
      FieldName = 'CODI_CTF'
    end
    object cdsTempCODI_CTC: TIntegerField
      FieldName = 'CODI_CTC'
    end
    object cdsTempCODI_CUL: TFloatField
      FieldName = 'CODI_CUL'
    end
    object cdsTempAno: TIntegerField
      FieldName = 'Ano'
    end
    object cdsTempDia: TIntegerField
      FieldName = 'Dia'
    end
    object cdsTempMes: TStringField
      FieldName = 'Mes'
      Size = 15
    end
    object cdsTempQPER_IPE: TFloatField
      FieldName = 'QPER_IPE'
    end
    object cdsTempQuadrimestre: TStringField
      FieldName = 'Quadrimestre'
      Size = 10
    end
    object cdsTempValor: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'Valor'
    end
    object cdsTempQuantidade: TFloatField
      DisplayLabel = 'Quantidade Venda'
      FieldName = 'Quantidade'
    end
    object cdsTempCustoMed: TFloatField
      DisplayLabel = 'Custo M'#233'dio Data'
      FieldName = 'CustoMed'
    end
    object cdsTempCustoTab: TFloatField
      DisplayLabel = 'Custo Tabela Pre'#231'o'
      FieldName = 'CustoTab'
    end
    object cdsTempCustoMedFin: TFloatField
      DisplayLabel = 'Custo Gerencial Financeiro'
      FieldName = 'CustoMedFin'
    end
    object cdsTempValorDaTabela: TFloatField
      DisplayLabel = 'Valor da Tabela'
      FieldName = 'ValorDaTabela'
    end
    object cdsTempImposto: TFloatField
      DisplayLabel = 'Impostos'
      FieldName = 'Imposto'
    end
    object cdsTempRatDesp: TFloatField
      DisplayLabel = 'Rateio das Desp. Adm.'
      FieldName = 'RatDesp'
    end
    object cdsTempPis: TFloatField
      FieldName = 'Pis'
    end
    object cdsTempCofins: TFloatField
      FieldName = 'Cofins'
    end
    object cdsTempCODI_ROT: TIntegerField
      FieldName = 'CODI_ROT'
    end
    object cdsTempCODI_REG: TIntegerField
      FieldName = 'CODI_REG'
    end
    object cdsTempESTA_MUN: TStringField
      FieldName = 'ESTA_MUN'
      Size = 2
    end
    object cdsTempCODI_CIC: TIntegerField
      FieldName = 'CODI_CIC'
    end
    object cdsTempCODI_MUN: TIntegerField
      FieldName = 'CODI_MUN'
    end
    object cdsTempSemestre: TStringField
      FieldName = 'Semestre'
      Size = 15
    end
    object cdsTempTrimestre: TStringField
      FieldName = 'Trimestre'
      Size = 15
    end
    object cdsTempBimestre: TStringField
      FieldName = 'Bimestre'
      Size = 15
    end
    object cdsTempCOND_CON: TIntegerField
      FieldName = 'COND_CON'
    end
    object cdsTempCCFO_CFO: TStringField
      FieldName = 'CCFO_CFO'
      Size = 6
    end
    object cdsTempCODI_TOP: TIntegerField
      FieldName = 'CODI_TOP'
    end
    object cdsTempNUMEROSERIE: TStringField
      FieldName = 'NUMEROSERIE'
      Size = 15
    end
    object cdsTempCEST_PRO: TStringField
      FieldName = 'CEST_PRO'
      Size = 1
    end
    object cdsTempQTDE_INO: TFloatField
      FieldName = 'QTDE_INO'
    end
    object cdsTempQTE1_PRO: TFloatField
      FieldName = 'QTE1_PRO'
    end
    object cdsTempQTE2_PRO: TFloatField
      FieldName = 'QTE2_PRO'
    end
    object cdsTempVLIQ_INO: TFloatField
      FieldName = 'VLIQ_INO'
    end
    object cdsTempCustoCompra: TFloatField
      DisplayLabel = 'Custo de Compra'
      FieldName = 'CustoCompra'
    end
    object cdsTempCustoMisto: TFloatField
      DisplayLabel = 'Custo Misto'
      FieldName = 'CustoMisto'
    end
    object cdsTempQtdeEntregue: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'QtdeEntregue'
    end
    object cdsTempSaldo: TFloatField
      FieldKind = fkInternalCalc
      FieldName = 'Saldo'
    end
    object cdsTempCOD2_PES: TIntegerField
      FieldName = 'COD2_PES'
    end
    object cdsTempCOMISSAO_VEND1: TFloatField
      DisplayLabel = 'Comiss'#227'o Vend 1'
      FieldName = 'COMISSAO_VEND1'
    end
    object cdsTempCOMISSAO_VEND2: TFloatField
      DisplayLabel = 'Comiss'#227'o Vend 2'
      FieldName = 'COMISSAO_VEND2'
    end
    object cdsTempCOMISSAO_TOTAL: TFloatField
      DisplayLabel = 'Comiss'#227'o Total'
      FieldName = 'COMISSAO_TOTAL'
    end
    object cdsTempDESPESAS: TFloatField
      DisplayLabel = 'D.A./Frete'
      FieldName = 'DESPESAS'
    end
    object cdsTempDOC_SERIE: TStringField
      FieldName = 'DOC_SERIE'
    end
  end
  object sqcTemp: TSQLiteClientDataSet
    Params = <>
    Left = 376
    Top = 200
    object sqcTempQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object sqcTempUNID_PSV: TStringField
      FieldName = 'UNID_PSV'
      Size = 3
    end
    object sqcTempCODI_EMP: TSmallintField
      FieldName = 'CODI_EMP'
    end
    object sqcTempCODI_PES: TIntegerField
      FieldName = 'CODI_PES'
    end
    object sqcTempCODI_PSV: TStringField
      FieldName = 'CODI_PSV'
      Size = 15
    end
    object sqcTempDEMI: TDateField
      FieldName = 'DEMI'
    end
    object sqcTempCODI_TRA: TIntegerField
      FieldName = 'CODI_TRA'
    end
    object sqcTempCODI_FOR: TIntegerField
      FieldName = 'CODI_FOR'
    end
    object sqcTempCODI_GPR: TIntegerField
      FieldName = 'CODI_GPR'
    end
    object sqcTempCODI_SBG: TStringField
      FieldName = 'CODI_SBG'
    end
    object sqcTempCODI_TIP: TIntegerField
      FieldName = 'CODI_TIP'
    end
    object sqcTempCODI_CTF: TIntegerField
      FieldName = 'CODI_CTF'
    end
    object sqcTempCODI_CTC: TIntegerField
      FieldName = 'CODI_CTC'
    end
    object sqcTempCODI_CUL: TFloatField
      FieldName = 'CODI_CUL'
    end
    object sqcTempAno: TIntegerField
      FieldName = 'Ano'
    end
    object sqcTempMes: TStringField
      FieldName = 'Mes'
      Size = 15
    end
    object sqcTempDia: TIntegerField
      FieldName = 'Dia'
    end
    object sqcTempQuadrimestre: TStringField
      FieldName = 'Quadrimestre'
      Size = 10
    end
    object sqcTempSemestre: TStringField
      FieldName = 'Semestre'
      Size = 15
    end
    object sqcTempTrimestre: TStringField
      FieldName = 'Trimestre'
      Size = 15
    end
    object sqcTempBimestre: TStringField
      FieldName = 'Bimestre'
      Size = 15
    end
    object sqcTempQPER_IPE: TFloatField
      FieldName = 'QPER_IPE'
    end
    object sqcTempValor: TFloatField
      DisplayLabel = 'Pre'#231'o Venda'
      FieldName = 'Valor'
    end
    object sqcTempQuantidade: TFloatField
      DisplayLabel = 'Quantidade Venda'
      FieldName = 'Quantidade'
    end
    object sqcTempCustoMed: TFloatField
      DisplayLabel = 'Custo M'#233'dio Data'
      FieldName = 'CustoMed'
    end
    object sqcTempCustoTab: TFloatField
      DisplayLabel = 'Custo Tabela Pre'#231'o'
      FieldName = 'CustoTab'
    end
    object sqcTempCustoMedFin: TFloatField
      DisplayLabel = 'Custo Gerencial Financeiro'
      FieldName = 'CustoMedFin'
    end
    object sqcTempValorDaTabela: TFloatField
      DisplayLabel = 'Valor da Tabela'
      FieldName = 'ValorDaTabela'
    end
    object sqcTempImposto: TFloatField
      DisplayLabel = 'Impostos'
      FieldName = 'Imposto'
    end
    object sqcTempRatDesp: TFloatField
      DisplayLabel = 'Rateio das Desp. Adm.'
      FieldName = 'RatDesp'
    end
    object sqcTempPis: TFloatField
      FieldName = 'Pis'
    end
    object sqcTempCofins: TFloatField
      FieldName = 'Cofins'
    end
    object sqcTempCODI_ROT: TIntegerField
      FieldName = 'CODI_ROT'
    end
    object sqcTempCODI_REG: TIntegerField
      FieldName = 'CODI_REG'
    end
    object sqcTempESTA_MUN: TStringField
      FieldName = 'ESTA_MUN'
      Size = 2
    end
    object sqcTempCODI_CIC: TIntegerField
      FieldName = 'CODI_CIC'
    end
    object sqcTempCODI_MUN: TIntegerField
      FieldName = 'CODI_MUN'
    end
    object sqcTempCOND_CON: TIntegerField
      FieldName = 'COND_CON'
    end
    object sqcTempCCFO_CFO: TStringField
      FieldName = 'CCFO_CFO'
      Size = 6
    end
    object sqcTempCODI_TOP: TIntegerField
      FieldName = 'CODI_TOP'
    end
    object sqcTempNUMEROSERIE: TStringField
      FieldName = 'NUMEROSERIE'
      Size = 15
    end
    object sqcTempCEST_PRO: TStringField
      FieldName = 'CEST_PRO'
      Size = 1
    end
    object sqcTempQTDE_INO: TFloatField
      FieldName = 'QTDE_INO'
    end
    object sqcTempQTE1_PRO: TFloatField
      FieldName = 'QTE1_PRO'
    end
    object sqcTempQTE2_PRO: TFloatField
      FieldName = 'QTE2_PRO'
    end
    object sqcTempVLIQ_INO: TFloatField
      FieldName = 'VLIQ_INO'
    end
    object sqcTempCustoCompra: TFloatField
      DisplayLabel = 'Custo de Compra'
      FieldName = 'CustoCompra'
    end
    object sqcTempCustoMisto: TFloatField
      DisplayLabel = 'Custo Misto'
      FieldName = 'CustoMisto'
    end
    object sqcTempQtdeEntregue: TFloatField
      FieldName = 'QtdeEntregue'
    end
    object sqcTempSaldo: TFloatField
      FieldName = 'Saldo'
    end
    object sqcTempCOD2_PES: TIntegerField
      FieldName = 'COD2_PES'
    end
    object sqcTempCOMISSAO_VEND1: TFloatField
      DisplayLabel = 'Comiss'#227'o Vend 1'
      FieldName = 'COMISSAO_VEND1'
    end
    object sqcTempCOMISSAO_VEND2: TFloatField
      DisplayLabel = 'Comiss'#227'o Vend 2'
      FieldName = 'COMISSAO_VEND2'
    end
    object sqcTempCOMISSAO_TOTAL: TFloatField
      DisplayLabel = 'Comiss'#227'o Total'
      FieldName = 'COMISSAO_TOTAL'
    end
    object sqcTempDESPESAS: TFloatField
      DisplayLabel = 'D.A./Frete'
      FieldName = 'DESPESAS'
    end
    object sqcTempDOC_SERIE: TStringField
      FieldName = 'DOC_SERIE'
    end
  end
end

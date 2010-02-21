unit CuboTestForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DBXFirebird, FMTBcd, StdCtrls, SQLiteClientDataSet,
  SQLiteDataSetProvider, DBClient, Provider, DB, SqlExpr, CheckLst, ComCtrls;

type
  TForm2 = class(TForm)
    SQLConnection2: TSQLConnection;
    SQLQuery1: TSQLQuery;
    DataSetProvider1: TDataSetProvider;
    cdsVendas: TClientDataSet;
    SQLiteDataSetProvider1: TSQLiteDataSetProvider;
    sqcVendas: TSQLiteClientDataSet;
    Button1: TButton;
    Button2: TButton;
    cdsTemp: TClientDataSet;
    cdsTempQTDE: TFloatField;
    cdsTempUNID_PSV: TStringField;
    cdsTempCODI_EMP: TSmallintField;
    cdsTempCODI_PES: TIntegerField;
    cdsTempCODI_PSV: TStringField;
    cdsTempDEMI: TDateField;
    cdsTempCODI_TRA: TIntegerField;
    cdsTempCODI_FOR: TIntegerField;
    cdsTempCODI_GPR: TIntegerField;
    cdsTempCODI_SBG: TStringField;
    cdsTempCODI_TIP: TIntegerField;
    cdsTempCODI_CTF: TIntegerField;
    cdsTempCODI_CTC: TIntegerField;
    cdsTempCODI_CUL: TFloatField;
    cdsTempAno: TIntegerField;
    cdsTempMes: TStringField;
    cdsTempQPER_IPE: TFloatField;
    cdsTempDia: TIntegerField;
    cdsTempQuadrimestre: TStringField;
    cdsTempValor: TFloatField;
    cdsTempQuantidade: TFloatField;
    cdsTempCustoMed: TFloatField;
    cdsTempCustoTab: TFloatField;
    cdsTempCustoMedFin: TFloatField;
    cdsTempValorDaTabela: TFloatField;
    cdsTempImposto: TFloatField;
    cdsTempRatDesp: TFloatField;
    cdsTempPis: TFloatField;
    cdsTempCofins: TFloatField;
    cdsTempCODI_ROT: TIntegerField;
    cdsTempCODI_REG: TIntegerField;
    cdsTempESTA_MUN: TStringField;
    cdsTempCODI_CIC: TIntegerField;
    cdsTempCODI_MUN: TIntegerField;
    cdsTempSemestre: TStringField;
    cdsTempTrimestre: TStringField;
    cdsTempBimestre: TStringField;
    cdsTempCOND_CON: TIntegerField;
    cdsTempCCFO_CFO: TStringField;
    cdsTempCODI_TOP: TIntegerField;
    cdsTempNUMEROSERIE: TStringField;
    cdsTempCEST_PRO: TStringField;
    cdsTempQTDE_INO: TFloatField;
    cdsTempQTE1_PRO: TFloatField;
    cdsTempQTE2_PRO: TFloatField;
    cdsTempVLIQ_INO: TFloatField;
    cdsTempCustoCompra: TFloatField;
    cdsTempCustoMisto: TFloatField;
    cdsTempQtdeEntregue: TFloatField;
    cdsTempSaldo: TFloatField;
    cdsTempCOD2_PES: TIntegerField;
    cdsTempCOMISSAO_VEND1: TFloatField;
    cdsTempCOMISSAO_VEND2: TFloatField;
    cdsTempCOMISSAO_TOTAL: TFloatField;
    cdsTempDOC_SERIE: TStringField;
    cdsTempDESPESAS: TFloatField;
    clbEntidades: TCheckListBox;
    ProgressBar: TProgressBar;
    cdsVendasDEMI: TDateField;
    cdsVendasCODI_EMP: TSmallintField;
    cdsVendasCODI_IND: TIntegerField;
    cdsVendasDATA_VLR: TDateField;
    cdsVendasFUNC_TOP: TStringField;
    cdsVendasCODI_TRA: TIntegerField;
    cdsVendasCODI_CTC: TIntegerField;
    cdsVendasCODI_PSV: TStringField;
    cdsVendasCODI_FOR: TIntegerField;
    cdsVendasCODI_GPR: TIntegerField;
    cdsVendasCODI_SBG: TIntegerField;
    cdsVendasCODI_TIP: TIntegerField;
    cdsVendasCODI_CTF: TIntegerField;
    cdsVendasCEST_PRO: TStringField;
    cdsVendasQTE1_PRO: TFloatField;
    cdsVendasQTE2_PRO: TFloatField;
    cdsVendasQTDE_INO: TFloatField;
    cdsVendasCOD1_PES: TIntegerField;
    cdsVendasCMVD_INO: TFloatField;
    cdsVendasCTAB_INO: TFloatField;
    cdsVendasVALORTOTAL: TFloatField;
    cdsVendasPVTB: TFloatField;
    cdsVendasCODI_CUL: TFloatField;
    cdsVendasPIS: TFloatField;
    cdsVendasCOFINS: TFloatField;
    cdsVendasICMS: TFloatField;
    cdsVendasCGFI: TFloatField;
    cdsVendasCODI_REG: TIntegerField;
    cdsVendasCODI_ROT: TIntegerField;
    cdsVendasCODI_MUN: TIntegerField;
    cdsVendasESTA_MUN: TStringField;
    cdsVendasPNFO_TOP: TStringField;
    cdsVendasTIPO_DOC: TStringField;
    cdsVendasTRAO: TIntegerField;
    cdsVendasNOTO: TIntegerField;
    cdsVendasSERO: TStringField;
    cdsVendasITEO: TIntegerField;
    cdsVendasCODI_CIC: TIntegerField;
    cdsVendasCOND_CON: TIntegerField;
    cdsVendasCMNO_TOP: TStringField;
    cdsVendasCCFO_CFO: TStringField;
    cdsVendasCODI_TOP: TIntegerField;
    cdsVendasCCPD_INO: TFloatField;
    cdsVendasCCODI_PES: TIntegerField;
    cdsVendasCOMP_CFO: TStringField;
    cdsVendasUNID_PSV: TStringField;
    cdsVendasVLIQ_INO: TFloatField;
    cdsVendasTABE_CTA: TIntegerField;
    cdsVendasCCOD2_PES: TIntegerField;
    cdsVendasCOD2_PES: TIntegerField;
    cdsVendasCOMISSAO_VEND1: TFloatField;
    cdsVendasCOMISSAO_VEND2: TFloatField;
    cdsVendasCOMISSAO_TOTAL: TFloatField;
    cdsVendasTCUS_TAB: TStringField;
    cdsVendasDOC_SERIE: TStringField;
    cdsVendasDESCONTO: TFloatField;
    cdsVendasDESPESAS: TFloatField;
    sqcTemp: TSQLiteClientDataSet;
    sqcVendasCODI_EMP: TSmallintField;
    sqcVendasDEMI: TDateField;
    sqcVendasCODI_IND: TIntegerField;
    sqcVendasDATA_VLR: TDateField;
    sqcVendasCMNO_TOP: TStringField;
    sqcVendasFUNC_TOP: TStringField;
    sqcVendasCODI_TRA: TIntegerField;
    sqcVendasCODI_CTC: TIntegerField;
    sqcVendasCODI_PSV: TStringField;
    sqcVendasUNID_PSV: TStringField;
    sqcVendasCOD1_PES: TIntegerField;
    sqcVendasCOD2_PES: TIntegerField;
    sqcVendasCODI_FOR: TIntegerField;
    sqcVendasCODI_GPR: TIntegerField;
    sqcVendasCODI_SBG: TIntegerField;
    sqcVendasCODI_TIP: TIntegerField;
    sqcVendasCODI_CTF: TIntegerField;
    sqcVendasCEST_PRO: TStringField;
    sqcVendasQTE1_PRO: TFloatField;
    sqcVendasQTE2_PRO: TFloatField;
    sqcVendasQTDE_INO: TFloatField;
    sqcVendasVLIQ_INO: TFloatField;
    sqcVendasVALORTOTAL: TFloatField;
    sqcVendasDESPESAS: TFloatField;
    sqcVendasCMVD_INO: TFloatField;
    sqcVendasCTAB_INO: TFloatField;
    sqcVendasPVTB: TFloatField;
    sqcVendasCODI_CUL: TFloatField;
    sqcVendasPIS: TFloatField;
    sqcVendasCOFINS: TFloatField;
    sqcVendasICMS: TFloatField;
    sqcVendasCGFI: TFloatField;
    sqcVendasCCPD_INO: TFloatField;
    sqcVendasPNFO_TOP: TStringField;
    sqcVendasTIPO_DOC: TStringField;
    sqcVendasCODI_CIC: TIntegerField;
    sqcVendasCOND_CON: TIntegerField;
    sqcVendasTRAO: TIntegerField;
    sqcVendasNOTO: TIntegerField;
    sqcVendasSERO: TStringField;
    sqcVendasDOC_SERIE: TStringField;
    sqcVendasITEO: TIntegerField;
    sqcVendasCCODI_PES: TIntegerField;
    sqcVendasCCOD2_PES: TIntegerField;
    sqcVendasCODI_REG: TIntegerField;
    sqcVendasCODI_ROT: TIntegerField;
    sqcVendasCODI_MUN: TIntegerField;
    sqcVendasESTA_MUN: TStringField;
    sqcVendasCCFO_CFO: TStringField;
    sqcVendasCODI_TOP: TIntegerField;
    sqcVendasCOMP_CFO: TStringField;
    sqcVendasTABE_CTA: TIntegerField;
    sqcVendasDESCONTO: TFloatField;
    sqcVendasTCUS_TAB: TStringField;
    sqcVendasCOMISSAO_VEND1: TFloatField;
    sqcVendasCOMISSAO_VEND2: TFloatField;
    sqcVendasCOMISSAO_TOTAL: TFloatField;
    sqcTempQTDE: TFloatField;
    sqcTempUNID_PSV: TStringField;
    sqcTempCODI_EMP: TSmallintField;
    sqcTempCODI_PES: TIntegerField;
    sqcTempCODI_PSV: TStringField;
    sqcTempDEMI: TDateField;
    sqcTempCODI_TRA: TIntegerField;
    sqcTempCODI_FOR: TIntegerField;
    sqcTempCODI_GPR: TIntegerField;
    sqcTempCODI_SBG: TStringField;
    sqcTempCODI_TIP: TIntegerField;
    sqcTempCODI_CTF: TIntegerField;
    sqcTempCODI_CTC: TIntegerField;
    sqcTempCODI_CUL: TFloatField;
    sqcTempAno: TIntegerField;
    sqcTempMes: TStringField;
    sqcTempQPER_IPE: TFloatField;
    sqcTempDia: TIntegerField;
    sqcTempQuadrimestre: TStringField;
    sqcTempValor: TFloatField;
    sqcTempQuantidade: TFloatField;
    sqcTempCustoMed: TFloatField;
    sqcTempCustoTab: TFloatField;
    sqcTempCustoMedFin: TFloatField;
    sqcTempValorDaTabela: TFloatField;
    sqcTempImposto: TFloatField;
    sqcTempRatDesp: TFloatField;
    sqcTempPis: TFloatField;
    sqcTempCofins: TFloatField;
    sqcTempCODI_ROT: TIntegerField;
    sqcTempCODI_REG: TIntegerField;
    sqcTempESTA_MUN: TStringField;
    sqcTempCODI_CIC: TIntegerField;
    sqcTempCODI_MUN: TIntegerField;
    sqcTempSemestre: TStringField;
    sqcTempTrimestre: TStringField;
    sqcTempBimestre: TStringField;
    sqcTempCOND_CON: TIntegerField;
    sqcTempCCFO_CFO: TStringField;
    sqcTempCODI_TOP: TIntegerField;
    sqcTempNUMEROSERIE: TStringField;
    sqcTempCEST_PRO: TStringField;
    sqcTempQTDE_INO: TFloatField;
    sqcTempQTE1_PRO: TFloatField;
    sqcTempQTE2_PRO: TFloatField;
    sqcTempVLIQ_INO: TFloatField;
    sqcTempCustoCompra: TFloatField;
    sqcTempCustoMisto: TFloatField;
    sqcTempQtdeEntregue: TFloatField;
    sqcTempSaldo: TFloatField;
    sqcTempCOD2_PES: TIntegerField;
    sqcTempCOMISSAO_VEND1: TFloatField;
    sqcTempCOMISSAO_VEND2: TFloatField;
    sqcTempCOMISSAO_TOTAL: TFloatField;
    sqcTempDESPESAS: TFloatField;
    sqcTempDOC_SERIE: TStringField;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure RetornaIndexFields(demi: TDateTime; codi_emp, codi_pes, cod2_pes,
      codi_tra, codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf, codi_ctc,
      codi_rot, codi_reg, codi_mun, codi_cic, cond_con, codi_top: Integer;
      codi_psv, esta_mun, ccfo_cfo: String; codi_cul: Double;
      var NomeIndexFields: String; var NomeFields, ValueFields: Variant;
      var QtdeCampos: Integer; doc_serie: String);
    procedure AddPsv(demi: TDateTime; codi_emp, codi_pes, cod2_pes, codi_tra,
      codi_for, codi_gpr: Integer; codi_sbg: String; codi_tip, codi_ctf,
      codi_ctc: Integer; codi_psv, ccfo_cfo: String; codi_cul: Double; codi_rot,
      codi_reg, codi_mun: Integer; esta_mun: String; codi_cic, cond_con,
      codi_top: integer; doc_serie: string);
    procedure SomaMvt(demi: TDateTime; codi_emp, codi_pes, cod2_pes, codi_tra,
      codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf, codi_ctc: Integer;
      codi_psv, ccfo_cfo: String; codi_cul: Double; codi_rot, codi_reg,
      codi_mun: Integer; esta_mun: String; codi_cic, cond_con,
      codi_top: Integer; var qtde_psv, tota_psv, cust_med, cust_tab, cust_com,
      vlor_tab, pis_psv, cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
      qtde_ent, sald_ent, comissao_vend1, comissao_vend2, comissao_total,
      despesas_frete: Double; doc_serie: string);
    procedure AtualizaValores;
    procedure AtualizaValores2;
    procedure AddPsv2(demi: TDateTime; codi_emp, codi_pes, cod2_pes, codi_tra,
      codi_for, codi_gpr: Integer; codi_sbg: String; codi_tip, codi_ctf,
      codi_ctc: Integer; codi_psv, ccfo_cfo: String; codi_cul: Double; codi_rot,
      codi_reg, codi_mun: Integer; esta_mun: String; codi_cic, cond_con,
      codi_top: integer; doc_serie: string);
    procedure SomaMvt2(demi: TDateTime; codi_emp, codi_pes, cod2_pes, codi_tra,
      codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf, codi_ctc: Integer;
      codi_psv, ccfo_cfo: String; codi_cul: Double; codi_rot, codi_reg,
      codi_mun: Integer; esta_mun: String; codi_cic, cond_con,
      codi_top: Integer; var qtde_psv, tota_psv, cust_med, cust_tab, cust_com,
      vlor_tab, pis_psv, cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
      qtde_ent, sald_ent, comissao_vend1, comissao_vend2, comissao_total,
      despesas_frete: Double; doc_serie: string);
    { Private declarations }
  public
    lNomeIndexFields: String;
    lQtdeCampos: Integer;
    lNomeFields, lValueFields: Variant;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.RetornaIndexFields(demi: TDateTime; codi_emp, codi_pes, cod2_pes, codi_tra,
  codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf, codi_ctc, codi_rot,
  codi_reg, codi_mun, codi_cic, cond_con, codi_top: Integer; codi_psv, esta_mun, ccfo_cfo: String;
  codi_cul: Double; var NomeIndexFields: String;
  var NomeFields, ValueFields: Variant; var QtdeCampos: Integer; doc_serie: String);
var
  lIndex: Integer;
  Contador: Integer;
begin
   QtdeCampos := 0;

   for lIndex := 0 to clbEntidades.Count - 1 do
   begin
      if clbEntidades.Checked[lIndex] then
      begin
         if (clbEntidades.Items[lIndex] <> 'Ano') and
            (clbEntidades.Items[lIndex] <> 'Semestre') and
            (clbEntidades.Items[lIndex] <> 'Quadrimestre') and
            (clbEntidades.Items[lIndex] <> 'Bimestre') and
            (clbEntidades.Items[lIndex] <> 'Trimestre') and
            (clbEntidades.Items[lIndex] <> 'Mês') and
            (clbEntidades.Items[lIndex] <> 'Dia') and
            (clbEntidades.Items[lIndex] <> 'Grupos/SugGrupos de Material') then
            Inc(QtdeCampos, 1)
         else if (clbEntidades.Items[lIndex] = 'Grupos/SugGrupos de Material') then
            Inc(QtdeCampos, 3);
      end;
   end;

   NomeFields      := VarArrayCreate([0, QtdeCampos], varVariant);
   NomeFields[0]   := 'DEMI';
   ValueFields     := VarArrayCreate([0, QtdeCampos], varVariant);
   ValueFields[0]  := demi;

   Contador := 0;

   for lIndex := 0 to clbEntidades.Count - 1 do
   begin
      if clbEntidades.Checked[lIndex] then
      begin
         if (clbEntidades.Items[lIndex] = 'Empresas') then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_EMP';

            if codi_emp <> 0 then
               ValueFields[Contador] := codi_emp
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Vendedor 1' then
         begin
            Inc(Contador);

            NomeFields[Contador]  := 'CCODI_PES';

            if codi_pes <> 0 then
               ValueFields[Contador] := codi_pes
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Vendedor 2' then
         begin
            Inc(Contador);

            NomeFields[Contador]  := 'COD2_PES';

            if cod2_pes <> 0 then
               ValueFields[Contador] := cod2_pes
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Clientes' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_TRA';

            if codi_tra <> 0 then
               ValueFields[Contador] := codi_tra
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Categorias de Cliente' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_CTC';

            if codi_ctc <> 0 then
               ValueFields[Contador] := codi_ctc
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Materiais' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_PSV';

            if codi_psv <> '' then
               ValueFields[Contador] := codi_psv
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Grupos/SugGrupos de Material' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_GPR';

            if codi_gpr <> 0 then
               ValueFields[Contador] := codi_gpr
            else
               ValueFields[Contador] := null;

            Inc(Contador);
            NomeFields[Contador]  := 'CODI_SBG';

            if codi_sbg <> 0 then
               ValueFields[Contador] := codi_sbg
            else
               ValueFields[Contador] := null;

            Inc(Contador);
            NomeFields[Contador]  := 'CODI_PSV';

            if codi_psv <> '' then
               ValueFields[Contador] := codi_psv
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Tipos de Material' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_TIP';

            if codi_tip <> 0 then
               ValueFields[Contador] := codi_tip
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Fabricantes' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_FOR';

            if codi_for <> 0 then
               ValueFields[Contador] := codi_for
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Categorias de Fabricante' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_CTF';

            if codi_ctf <> 0 then
               ValueFields[Contador] := codi_ctf
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Culturas' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_CUL';

            if codi_cul <> 0 then
               ValueFields[Contador] := codi_cul
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Regiões' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_REG';

            if codi_reg <> 0 then
               ValueFields[Contador] := codi_reg
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Municípios' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_MUN';

            if codi_mun <> 0 then
               ValueFields[Contador] := codi_mun
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Estados' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'ESTA_MUN';

            if esta_mun <> '' then
               ValueFields[Contador] := esta_mun
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Rotas' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_ROT';

            if codi_rot <> 0 then
               ValueFields[Contador] := codi_rot
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Ciclo de Produção' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_CIC';

            if codi_cic <> 0 then
               ValueFields[Contador] := codi_cic
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Condição de Pagamento' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'COND_CON';

            if cond_con <> 0 then
               ValueFields[Contador] := cond_con
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'CFOP' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CCFO_CFO';

            if ccfo_cfo <> '' then
               ValueFields[Contador] := ccfo_cfo
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Tipo de Operação' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'CODI_TOP';

            if codi_top <> 0 then
               ValueFields[Contador] := codi_top
            else
               ValueFields[Contador] := null;
         end
         else if clbEntidades.Items[lIndex] = 'Documento/Série' then
         begin
            Inc(Contador);
            NomeFields[Contador]  := 'DOC_SERIE';

            if codi_top <> 0 then
               ValueFields[Contador] := doc_serie
            else
               ValueFields[Contador] := null;
         end;
      end;
   end;

   NomeIndexFields := 'DEMI';

   for lIndex := 1 to QtdeCampos -1 do
      NomeIndexFields := NomeIndexFields + ';' + NomeFields[lIndex];
end;

procedure TForm2.AddPsv(demi: TDateTime; codi_emp: Integer; codi_pes, cod2_pes: Integer;
                codi_tra: Integer; codi_for: Integer; codi_gpr: Integer;
                codi_sbg: String; codi_tip: Integer; codi_ctf: Integer;
                codi_ctc: Integer; codi_psv, ccfo_cfo : String; codi_cul: Double;
                codi_rot: Integer; codi_reg: Integer; codi_mun: Integer;
                esta_mun: String; codi_cic, cond_con, codi_top: integer; doc_serie: string);
begin
     cdsTemp.Append;
     cdsTempDEMI.AsDateTime    := demi;
     cdsTempCODI_EMP.AsInteger := codi_emp;
     cdsTempCODI_PES.AsInteger := codi_pes;
     cdsTempCOD2_PES.AsInteger := cod2_pes;
     cdsTempCODI_TRA.AsInteger := codi_tra;
     cdsTempCODI_FOR.AsInteger := codi_for;
     cdsTempCODI_GPR.AsInteger := codi_gpr;
     cdsTempCODI_SBG.AsString  := codi_sbg;
     cdsTempCODI_TIP.AsInteger := codi_tip;
     cdsTempCODI_CTF.AsInteger := codi_ctf;
     cdsTempCODI_CTC.AsInteger := codi_ctc;
     cdsTempCODI_PSV.AsString  := codi_psv;
     cdsTempCODI_CUL.AsFloat   := codi_cul;
     cdsTempCODI_ROT.AsInteger := codi_rot;
     cdsTempCODI_REG.AsInteger := codi_reg;
     cdsTempCODI_MUN.AsInteger := codi_mun;
     cdsTempESTA_MUN.AsString  := esta_mun;
     cdsTempCODI_CIC.AsInteger := codi_cic;
     cdsTempCOND_CON.AsInteger := cond_con;
     cdsTempCCFO_CFO.AsString  := ccfo_cfo;
     cdsTempCODI_TOP.AsInteger := codi_top;
     cdsTempDOC_SERIE.AsString := doc_serie;

end;

procedure TForm2.SomaMvt(demi: TDateTime; codi_emp: Integer; codi_pes, cod2_pes: Integer;
                 codi_tra: Integer; codi_for: Integer; codi_gpr: Integer;
                 codi_sbg: Integer; codi_tip: Integer; codi_ctf: Integer;
                 codi_ctc: Integer; codi_psv, ccfo_cfo: String; codi_cul: Double;
                 codi_rot: Integer; codi_reg: Integer; codi_mun: Integer;
                 esta_mun: String; codi_cic, cond_con, codi_top: Integer;
                 var qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab,
                 pis_psv, cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
                 qtde_ent, sald_ent,comissao_vend1,comissao_vend2,comissao_total, despesas_frete: Double; doc_serie : string);

var
  lindex:Double;

  function CheckDados: Boolean;
  var
   I: Integer;
  begin
    Result := True;
    for I := 0 to lQtdeCampos do
    begin
          if not (cdsVendas.FieldByName(lNomeFields[I]).Value = lValueFields[I]) then
          begin
             Result := False;
             Break;
          end;
    end;
  end;

begin

 RetornaIndexFields(demi, codi_emp, codi_pes, cod2_pes, codi_tra,
            codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf,
            codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic,
            cond_con, codi_top, codi_psv, esta_mun, ccfo_cfo, codi_cul,
            lNomeIndexFields, lNomeFields, lValueFields, lQtdeCampos, doc_Serie);

    cdsVendas.Locate(lNomeIndexFields, lValueFields, []);
    while CheckDados do
    begin
       //Application.ProcessaMsg;
       ProgressBar.StepIt;

       //if (cdsVendasPNFO_TOP.AsString = 'S') and (cdsVendasCOMP_CFO.AsString = '1') then
       //   BuscaDadosNotaOrigem;

       case cdsVendasFUNC_TOP.Value[1] of
          'A':
          begin
{                 if chbAgrupaProdutos.Checked then
             begin
                if cdsVendasCEST_PRO.AsString = 'P' then
                   qtde_psv := qtde_psv + (cdsVendasQTDE_INO.Value * cdsVendasQTE1_PRO.Value)
                else if cdsVendasCEST_PRO.AsString = 'S' then
                   qtde_psv := qtde_psv + (cdsVendasQTDE_INO.Value * cdsVendasQTE2_PRO.Value * cdsVendasQTE1_PRO.Value)
                else
                   qtde_psv := qtde_psv + cdsVendasQTDE_INO.Value;
             end
             else}
                qtde_psv := qtde_psv + cdsVendasQTDE_INO.Value;

             {if(cbxPontualidade.Checked) then
                tota_psv := tota_psv + cdsVendasVALORTOTAL.Value - (cdsVendasVALORTOTAL.AsFloat * (cdsVendasDESCONTO.AsFloat / 100))
             else}
                tota_psv := tota_psv + cdsVendasVALORTOTAL.Value;

             cust_med         := cust_med       + cdsVendasCMVD_INO.Value;
             cust_tab         := cust_tab       + cdsVendasCTAB_INO.Value;
             cust_com         := cust_com       + cdsVendasCCPD_INO.Value;
             vlor_tab         := vlor_tab       + cdsVendasPVTB.Value;
             pis_psv          := pis_psv        + cdsVendasPIS.Value;
             cofins_psv       := cofins_psv     + cdsVendasCOFINS.Value;
             icms_psv         := icms_psv       + cdsVendasICMS.Value;
             cfin_psv         := cfin_psv       + cdsVendasCGFI.Value;
             comissao_vend1   := comissao_vend1 + cdsVendasCOMISSAO_VEND1.Value;
             comissao_vend2   := comissao_vend2 + cdsVendasCOMISSAO_VEND2.Value;
             comissao_total   := comissao_total + cdsVendasCOMISSAO_TOTAL.Value;
             despesas_frete   := despesas_frete + cdsVendasDESPESAS.Value;

             if (cdsVendasTABE_CTA.AsString <> '') and (cdsVendasCODI_PSV.AsString <> '') then
             begin
                if (cdsVendasTCUS_TAB.AsString = '1') then
                    cust_mis := cust_mis + cdsVendasCTAB_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '2') then
                    cust_mis := cust_mis + cdsVendasCTAB_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '3') then
                    cust_mis := cust_mis + cdsVendasCMVD_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '4') then
                    cust_mis := cust_mis + cdsVendasCCPD_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '5') then
                    cust_mis := cust_mis + cdsVendasCGFI.Value;
             end;
          end;
          'S':
          begin
             {if chbAgrupaProdutos.Checked then
             begin
                if cdsVendasCEST_PRO.AsString = 'P' then
                   qtde_psv := qtde_psv - (cdsVendasQTDE_INO.Value * cdsVendasQTE1_PRO.Value)
                else if cdsVendasCEST_PRO.AsString = 'S' then
                   qtde_psv := qtde_psv - (cdsVendasQTDE_INO.Value * cdsVendasQTE2_PRO.Value * cdsVendasQTE1_PRO.Value)
                else
                   qtde_psv := qtde_psv - cdsVendasQTDE_INO.Value;
             end
             else}
                qtde_psv := qtde_psv - cdsVendasQTDE_INO.Value;

             tota_psv         := tota_psv       - cdsVendasVALORTOTAL.Value;
             cust_med         := cust_med       - cdsVendasCMVD_INO.Value;
             cust_tab         := cust_tab       - cdsVendasCTAB_INO.Value;
             cust_com         := cust_com       - cdsVendasCCPD_INO.Value;
             vlor_tab         := vlor_tab       - cdsVendasPVTB.Value;
             pis_psv          := pis_psv        - cdsVendasPIS.Value;
             cofins_psv       := cofins_psv     - cdsVendasCOFINS.Value;
             icms_psv         := icms_psv       - cdsVendasICMS.Value;
             cfin_psv         := cfin_psv       - cdsVendasCGFI.Value;
             comissao_vend1   := comissao_vend1 - cdsVendasCOMISSAO_VEND1.Value;
             comissao_vend2   := comissao_vend2 - cdsVendasCOMISSAO_VEND2.Value;
             comissao_total   := comissao_total - cdsVendasCOMISSAO_TOTAL.Value;
             despesas_frete   := despesas_frete - cdsVendasDESPESAS.Value;

             if (cdsVendasTABE_CTA.AsString <> '') and (cdsVendasCODI_PSV.AsString <> '') then
             begin
                if (cdsVendasTCUS_TAB.AsString = '1') then
                   cust_mis := cust_mis - cdsVendasCTAB_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '2') then
                   cust_mis := cust_mis - cdsVendasCTAB_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '3') then
                   cust_mis := cust_mis - cdsVendasCMVD_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '4') then
                   cust_mis := cust_mis - cdsVendasCCPD_INO.Value
                else
                if (cdsVendasTCUS_TAB.AsString = '5') then
                   cust_mis := cust_mis - cdsVendasCGFI.Value;
             end;
          end;
       end;

       cdsVendas.Delete;
    end;
end;

procedure TForm2.AtualizaValores;
var
  lNomeIndexFields: String;
  lNomeFields, lValueFields: Variant;

  lQtdeCampos: Integer;
  VLOR_IPE, QTDE_IPE: Double;


var
  lIndex: Double;
  codi_psv, esta_mun, codi_sbg_tmp, ccfo_cfo, cest_pro, unid_psv, doc_serie : String;
  codi_emp, codi_pes, cod2_pes, codi_tra, codi_for, codi_gpr, codi_sbg, codi_tip,
  codi_ctf, codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic, cond_con,
  codi_top : Integer;
  codi_cul : Double;
  Vinculo : TStrings;
  qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab, pis_psv, cofins_psv,
  icms_psv, qper_psv, cfin_psv, qte1_pro, qte2_pro, vliq_ino, cust_mis, qtde_ent,
  sald_ent: Double;
  CodigoVendedor, CodigoVendedor2, lIndLoop: Integer;
  demi: TDateTime;
  vinculocli:integer;
  SaldoProduto, CustoFinan, SaldoAux, PrecoAux,
  SaldoEmbalagem, PrecoEmbalagem: Double;
  comissao_vend1,
  comissao_vend2,
  comissao_total, despesas_frete : Double;
begin
  RetornaIndexFields(demi, codi_emp, codi_pes, cod2_pes, codi_tra,
             codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf,
             codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic,
             cond_con, codi_top, codi_psv, esta_mun, ccfo_cfo, codi_cul,
             lNomeIndexFields, lNomeFields, lValueFields, lQtdeCampos, doc_serie);

     {Indexa e transporta os valores agrupando por transacionador}
     cdsVendas.IndexFieldNames := lNomeIndexFields;

     ProgressBar.Visible := True;
     ProgressBar.Min     := 1;

     if cdsVendas.RecordCount >= 1 then
        ProgressBar.Max := cdsVendas.RecordCount
     else
        ProgressBar.Max := 1;

     cdsVendas.First;
     while not cdsVendas.IsEmpty do
     begin
        Application.ProcessMessages;
        demi     := cdsVendasDEMI.AsDateTime;
        codi_emp := cdsVendasCODI_EMP.AsInteger;

        codi_pes := cdsVendasCCODI_PES.asInteger;
        cod2_pes := cdsVendasCOD2_PES.AsInteger;

        codi_tra     := cdsVendasCODI_TRA.AsInteger;
        codi_for     := cdsVendasCODI_FOR.AsInteger;
        codi_gpr     := cdsVendasCODI_GPR.AsInteger;
        codi_sbg     := cdsVendasCODI_SBG.AsInteger;
        codi_sbg_tmp := IntToStr(cdsVendasCODI_GPR.AsInteger) + IntToStr(cdsVendasCODI_SBG.AsInteger);
        codi_tip     := cdsVendasCODI_TIP.AsInteger;
        codi_ctf     := cdsVendasCODI_CTF.AsInteger;
        codi_ctc     := cdsVendasCODI_CTC.AsInteger;
        codi_psv     := cdsVendasCODI_PSV.AsString;
        codi_cul     := cdsVendasCODI_CUL.AsFloat;
        codi_reg     := cdsVendasCODI_REG.AsInteger;
        codi_rot     := cdsVendasCODI_ROT.AsInteger;
        codi_mun     := cdsVendasCODI_MUN.AsInteger;
        esta_mun     := cdsVendasESTA_MUN.AsString;
        codi_cic     := cdsVendasCODI_CIC.ASINTEGER;
        cond_con     := cdsVendasCOND_CON.AsInteger;
        ccfo_cfo     := cdsVendasCCFO_CFO.AsString;
        codi_top     := cdsVendasCODI_TOP.AsInteger;
        cest_pro     := cdsVendasCEST_PRO.AsString;
        qte1_pro     := cdsVendasQTE1_PRO.AsFloat;
        qte2_pro     := cdsVendasQTE2_PRO.AsFloat;
        doc_serie    := cdsVendasDOC_SERIE.AsString;


        //Se a quantidade da embalagem primária for Zero ou Nula a mesma recebe 1
        if (qte1_pro = 0) or (qte1_pro = null) then
           qte1_pro := 1;

        //Se a quantidade da embalagem secundária for Zero ou Nula a mesma recebe 1
        if (qte2_pro = 0) or (qte2_pro = null) then
           qte2_pro := 1;

        unid_psv := cdsVendasUNID_PSV.AsString;
        vliq_ino := cdsVendasVLIQ_INO.AsFloat;


           CodigoVendedor := cdsVendasCCODI_PES.asInteger;
           CodigoVendedor2 := cdsVendasCCOD2_PES.asInteger;

           {Insere dados do produto}
           AddPsv(demi, codi_emp, CodigoVendedor, CodigoVendedor2 , codi_tra, codi_for, codi_gpr,
                  codi_sbg_tmp, codi_tip, codi_ctf, codi_ctc, cdsVendasCODI_PSV.AsString,
                  ccfo_cfo, codi_cul, codi_rot, codi_reg, codi_mun, esta_mun, codi_cic,
                  cond_con, codi_top, doc_serie);

           {Acha total da movimentação}
           qtde_psv       := 0;
           tota_psv       := 0;
           cust_med       := 0;
           cust_tab       := 0;
           cust_com       := 0;
           vlor_tab       := 0;
           pis_psv        := 0;
           cofins_psv     := 0;
           icms_psv       := 0;
           qper_psv       := 0;
           cfin_psv       := 0;
           cust_mis       := 0;
           qtde_ent       := 0;
           sald_ent       := 0;
           comissao_vend1 := 0;
           comissao_vend2 := 0;
           comissao_total := 0;
           despesas_frete := 0;

           SomaMvt(cdsVendasDEMI.AsDateTime, cdsVendasCODI_EMP.AsInteger,
                   CodigoVendedor, CodigoVendedor2, cdsVendasCODI_TRA.AsInteger,
                   cdsVendasCODI_FOR.AsInteger, cdsVendasCODI_GPR.AsInteger,
                   cdsVendasCODI_SBG.AsInteger,
                   cdsVendasCODI_TIP.AsInteger,
                   cdsVendasCODI_CTF.AsInteger, cdsVendasCODI_CTC.AsInteger,
                   cdsVendasCODI_PSV.AsString, cdsVendasCCFO_CFO.AsString,
                   cdsVendasCODI_CUL.AsFloat, cdsVendasCODI_ROT.AsInteger,
                   cdsVendasCODI_REG.AsInteger,cdsVendasCODI_MUN.AsInteger,
                   cdsVendasESTA_MUN.AsString, cdsVendasCODI_CIC.AsInteger,
                   cdsVendasCOND_CON.AsInteger, cdsVendasCODI_TOP.AsInteger,
                   qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab, pis_psv,
                   cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
                   qtde_ent, sald_ent,comissao_vend1,comissao_vend2,comissao_total,despesas_frete, doc_serie );

           {Grava total da movimentação}

              cdsTempQuantidade.Value  := qtde_psv;
           cdsTempQtdeEntregue.Value   := qtde_ent;
           cdsTempSaldo.Value          := sald_ent;
           cdsTempValor.Value          := tota_psv;
           cdsTempCustoMed.Value       := cust_med;
           cdsTempCustoTab.Value       := cust_tab;
           cdsTempCustoCompra.Value    := cust_com;
           cdsTempCustoMisto.Value     := cust_mis;
           cdsTempValorDaTabela.Value  := vlor_tab;
           cdsTempPis.Value            := pis_psv;
           cdsTempCofins.Value         := cofins_psv;
           cdsTempImposto.Value        := icms_psv;
           cdsTempCustoMedFin.Value    := cfin_psv;
           cdsTempCEST_PRO.Value       := cest_pro;
           cdsTempQTDE_INO.Value       := qtde_psv;
           cdsTempQTE1_PRO.Value       := qte1_pro;
           cdsTempQTE2_PRO.Value       := qte2_pro;
           cdsTempUNID_PSV.Value       := unid_psv;
           cdsTempQPER_IPE.Value       := qper_psv;
           cdsTempVLIQ_INO.Value       := vliq_ino;
           cdsTempCOMISSAO_VEND1.Value := comissao_vend1;
           cdsTempCOMISSAO_VEND2.Value := comissao_vend2;
           cdsTempCOMISSAO_TOTAL.Value := comissao_total;
           cdsTempDESPESAS.Value       := despesas_frete;

           cdsTemp.Post;
        end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  cdsTemp.CreateDataSet;
  cdsVendas.Open;
  AtualizaValores;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
  sqcTemp.CreateDataSet;
  sqcVendas.Open;
  AtualizaValores2;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
  lIndex: Integer;
begin
   for lIndex := 0 to clbEntidades.Count - 1 do
   begin
      if (clbEntidades.Items[lIndex] = 'Empresas') or
         (clbEntidades.Items[lIndex] = 'Vendedor 1') or
         (clbEntidades.Items[lIndex] = 'Clientes') or
         (clbEntidades.Items[lIndex] = 'Materiais') or
         (clbEntidades.Items[lIndex] = 'Grupos/SugGrupos de Material') or
         (clbEntidades.Items[lIndex] = 'Ano') or
         (clbEntidades.Items[lIndex] = 'Mês') then
         clbEntidades.Checked[lIndex] := True
      else
         clbEntidades.Checked[lIndex] := False;
   end;
end;


procedure TForm2.AtualizaValores2;
var
  lNomeIndexFields: String;
  lNomeFields, lValueFields: Variant;

  lQtdeCampos: Integer;
  VLOR_IPE, QTDE_IPE: Double;


var
  lIndex: Double;
  codi_psv, esta_mun, codi_sbg_tmp, ccfo_cfo, cest_pro, unid_psv, doc_serie : String;
  codi_emp, codi_pes, cod2_pes, codi_tra, codi_for, codi_gpr, codi_sbg, codi_tip,
  codi_ctf, codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic, cond_con,
  codi_top : Integer;
  codi_cul : Double;
  Vinculo : TStrings;
  qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab, pis_psv, cofins_psv,
  icms_psv, qper_psv, cfin_psv, qte1_pro, qte2_pro, vliq_ino, cust_mis, qtde_ent,
  sald_ent: Double;
  CodigoVendedor, CodigoVendedor2, lIndLoop: Integer;
  demi: TDateTime;
  vinculocli:integer;
  SaldoProduto, CustoFinan, SaldoAux, PrecoAux,
  SaldoEmbalagem, PrecoEmbalagem: Double;
  comissao_vend1,
  comissao_vend2,
  comissao_total, despesas_frete : Double;
begin
  RetornaIndexFields(demi, codi_emp, codi_pes, cod2_pes, codi_tra,
             codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf,
             codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic,
             cond_con, codi_top, codi_psv, esta_mun, ccfo_cfo, codi_cul,
             lNomeIndexFields, lNomeFields, lValueFields, lQtdeCampos, doc_serie);

     {Indexa e transporta os valores agrupando por transacionador}
     sqcVendas.IndexFieldNames := lNomeIndexFields;

     ProgressBar.Visible := True;
     ProgressBar.Min     := 1;

     if sqcVendas.RecordCount >= 1 then
        ProgressBar.Max := sqcVendas.RecordCount
     else
        ProgressBar.Max := 1;

     sqcVendas.First;
     while not sqcVendas.IsEmpty do
     begin
        Application.ProcessMessages;
        demi     := sqcVendasDEMI.AsDateTime;
        codi_emp := sqcVendasCODI_EMP.AsInteger;

        codi_pes := sqcVendasCCODI_PES.asInteger;
        cod2_pes := sqcVendasCOD2_PES.AsInteger;

        codi_tra     := sqcVendasCODI_TRA.AsInteger;
        codi_for     := sqcVendasCODI_FOR.AsInteger;
        codi_gpr     := sqcVendasCODI_GPR.AsInteger;
        codi_sbg     := sqcVendasCODI_SBG.AsInteger;
        codi_sbg_tmp := IntToStr(sqcVendasCODI_GPR.AsInteger) + IntToStr(sqcVendasCODI_SBG.AsInteger);
        codi_tip     := sqcVendasCODI_TIP.AsInteger;
        codi_ctf     := sqcVendasCODI_CTF.AsInteger;
        codi_ctc     := sqcVendasCODI_CTC.AsInteger;
        codi_psv     := sqcVendasCODI_PSV.AsString;
        codi_cul     := sqcVendasCODI_CUL.AsFloat;
        codi_reg     := sqcVendasCODI_REG.AsInteger;
        codi_rot     := sqcVendasCODI_ROT.AsInteger;
        codi_mun     := sqcVendasCODI_MUN.AsInteger;
        esta_mun     := sqcVendasESTA_MUN.AsString;
        codi_cic     := sqcVendasCODI_CIC.ASINTEGER;
        cond_con     := sqcVendasCOND_CON.AsInteger;
        ccfo_cfo     := sqcVendasCCFO_CFO.AsString;
        codi_top     := sqcVendasCODI_TOP.AsInteger;
        cest_pro     := sqcVendasCEST_PRO.AsString;
        qte1_pro     := sqcVendasQTE1_PRO.AsFloat;
        qte2_pro     := sqcVendasQTE2_PRO.AsFloat;
        doc_serie    := sqcVendasDOC_SERIE.AsString;


        //Se a quantidade da embalagem primária for Zero ou Nula a mesma recebe 1
        if (qte1_pro = 0) or (qte1_pro = null) then
           qte1_pro := 1;

        //Se a quantidade da embalagem secundária for Zero ou Nula a mesma recebe 1
        if (qte2_pro = 0) or (qte2_pro = null) then
           qte2_pro := 1;

        unid_psv := sqcVendasUNID_PSV.AsString;
        vliq_ino := sqcVendasVLIQ_INO.AsFloat;


           CodigoVendedor := sqcVendasCCODI_PES.asInteger;
           CodigoVendedor2 := sqcVendasCCOD2_PES.asInteger;

           {Insere dados do produto}
           AddPsv2(demi, codi_emp, CodigoVendedor, CodigoVendedor2 , codi_tra, codi_for, codi_gpr,
                  codi_sbg_tmp, codi_tip, codi_ctf, codi_ctc, sqcVendasCODI_PSV.AsString,
                  ccfo_cfo, codi_cul, codi_rot, codi_reg, codi_mun, esta_mun, codi_cic,
                  cond_con, codi_top, doc_serie);

           {Acha total da movimentação}
           qtde_psv       := 0;
           tota_psv       := 0;
           cust_med       := 0;
           cust_tab       := 0;
           cust_com       := 0;
           vlor_tab       := 0;
           pis_psv        := 0;
           cofins_psv     := 0;
           icms_psv       := 0;
           qper_psv       := 0;
           cfin_psv       := 0;
           cust_mis       := 0;
           qtde_ent       := 0;
           sald_ent       := 0;
           comissao_vend1 := 0;
           comissao_vend2 := 0;
           comissao_total := 0;
           despesas_frete := 0;

           SomaMvt2(sqcVendasDEMI.AsDateTime, sqcVendasCODI_EMP.AsInteger,
                   CodigoVendedor, CodigoVendedor2, sqcVendasCODI_TRA.AsInteger,
                   sqcVendasCODI_FOR.AsInteger, sqcVendasCODI_GPR.AsInteger,
                   sqcVendasCODI_SBG.AsInteger,
                   sqcVendasCODI_TIP.AsInteger,
                   sqcVendasCODI_CTF.AsInteger, sqcVendasCODI_CTC.AsInteger,
                   sqcVendasCODI_PSV.AsString, sqcVendasCCFO_CFO.AsString,
                   sqcVendasCODI_CUL.AsFloat, sqcVendasCODI_ROT.AsInteger,
                   sqcVendasCODI_REG.AsInteger,sqcVendasCODI_MUN.AsInteger,
                   sqcVendasESTA_MUN.AsString, sqcVendasCODI_CIC.AsInteger,
                   sqcVendasCOND_CON.AsInteger, sqcVendasCODI_TOP.AsInteger,
                   qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab, pis_psv,
                   cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
                   qtde_ent, sald_ent,comissao_vend1,comissao_vend2,comissao_total,despesas_frete, doc_serie );

           {Grava total da movimentação}

              sqcTempQuantidade.Value  := qtde_psv;
           sqcTempQtdeEntregue.Value   := qtde_ent;
           sqcTempSaldo.Value          := sald_ent;
           sqcTempValor.Value          := tota_psv;
           sqcTempCustoMed.Value       := cust_med;
           sqcTempCustoTab.Value       := cust_tab;
           sqcTempCustoCompra.Value    := cust_com;
           sqcTempCustoMisto.Value     := cust_mis;
           sqcTempValorDaTabela.Value  := vlor_tab;
           sqcTempPis.Value            := pis_psv;
           sqcTempCofins.Value         := cofins_psv;
           sqcTempImposto.Value        := icms_psv;
           sqcTempCustoMedFin.Value    := cfin_psv;
           sqcTempCEST_PRO.Value       := cest_pro;
           sqcTempQTDE_INO.Value       := qtde_psv;
           sqcTempQTE1_PRO.Value       := qte1_pro;
           sqcTempQTE2_PRO.Value       := qte2_pro;
           sqcTempUNID_PSV.Value       := unid_psv;
           sqcTempQPER_IPE.Value       := qper_psv;
           sqcTempVLIQ_INO.Value       := vliq_ino;
           sqcTempCOMISSAO_VEND1.Value := comissao_vend1;
           sqcTempCOMISSAO_VEND2.Value := comissao_vend2;
           sqcTempCOMISSAO_TOTAL.Value := comissao_total;
           sqcTempDESPESAS.Value       := despesas_frete;

           sqcTemp.Post;
        end;
end;

procedure TForm2.SomaMvt2(demi: TDateTime; codi_emp: Integer; codi_pes, cod2_pes: Integer;
                 codi_tra: Integer; codi_for: Integer; codi_gpr: Integer;
                 codi_sbg: Integer; codi_tip: Integer; codi_ctf: Integer;
                 codi_ctc: Integer; codi_psv, ccfo_cfo: String; codi_cul: Double;
                 codi_rot: Integer; codi_reg: Integer; codi_mun: Integer;
                 esta_mun: String; codi_cic, cond_con, codi_top: Integer;
                 var qtde_psv, tota_psv, cust_med, cust_tab, cust_com, vlor_tab,
                 pis_psv, cofins_psv, icms_psv, qper_psv, cfin_psv, cust_mis,
                 qtde_ent, sald_ent,comissao_vend1,comissao_vend2,comissao_total, despesas_frete: Double; doc_serie : string);

var
  lindex:Double;

  function CheckDados: Boolean;
  var
   I: Integer;
  begin
    Result := True;
    for I := 0 to lQtdeCampos do
    begin
          if not (sqcVendas.FieldByName(lNomeFields[I]).Value = lValueFields[I]) then
          begin
             Result := False;
             Break;
          end;
    end;
  end;

begin

 RetornaIndexFields(demi, codi_emp, codi_pes, cod2_pes, codi_tra,
            codi_for, codi_gpr, codi_sbg, codi_tip, codi_ctf,
            codi_ctc, codi_rot, codi_reg, codi_mun, codi_cic,
            cond_con, codi_top, codi_psv, esta_mun, ccfo_cfo, codi_cul,
            lNomeIndexFields, lNomeFields, lValueFields, lQtdeCampos, doc_Serie);

    sqcVendas.Locate(lNomeIndexFields, lValueFields, []);
    while CheckDados do
    begin
       //Application.ProcessaMsg;
       ProgressBar.StepIt;

       //if (sqcVendasPNFO_TOP.AsString = 'S') and (sqcVendasCOMP_CFO.AsString = '1') then
       //   BuscaDadosNotaOrigem;

       case sqcVendasFUNC_TOP.Value[1] of
          'A':
          begin
{                 if chbAgrupaProdutos.Checked then
             begin
                if sqcVendasCEST_PRO.AsString = 'P' then
                   qtde_psv := qtde_psv + (sqcVendasQTDE_INO.Value * sqcVendasQTE1_PRO.Value)
                else if sqcVendasCEST_PRO.AsString = 'S' then
                   qtde_psv := qtde_psv + (sqcVendasQTDE_INO.Value * sqcVendasQTE2_PRO.Value * sqcVendasQTE1_PRO.Value)
                else
                   qtde_psv := qtde_psv + sqcVendasQTDE_INO.Value;
             end
             else}
                qtde_psv := qtde_psv + sqcVendasQTDE_INO.Value;

             {if(cbxPontualidade.Checked) then
                tota_psv := tota_psv + sqcVendasVALORTOTAL.Value - (sqcVendasVALORTOTAL.AsFloat * (sqcVendasDESCONTO.AsFloat / 100))
             else}
                tota_psv := tota_psv + sqcVendasVALORTOTAL.Value;

             cust_med         := cust_med       + sqcVendasCMVD_INO.Value;
             cust_tab         := cust_tab       + sqcVendasCTAB_INO.Value;
             cust_com         := cust_com       + sqcVendasCCPD_INO.Value;
             vlor_tab         := vlor_tab       + sqcVendasPVTB.Value;
             pis_psv          := pis_psv        + sqcVendasPIS.Value;
             cofins_psv       := cofins_psv     + sqcVendasCOFINS.Value;
             icms_psv         := icms_psv       + sqcVendasICMS.Value;
             cfin_psv         := cfin_psv       + sqcVendasCGFI.Value;
             comissao_vend1   := comissao_vend1 + sqcVendasCOMISSAO_VEND1.Value;
             comissao_vend2   := comissao_vend2 + sqcVendasCOMISSAO_VEND2.Value;
             comissao_total   := comissao_total + sqcVendasCOMISSAO_TOTAL.Value;
             despesas_frete   := despesas_frete + sqcVendasDESPESAS.Value;

             if (sqcVendasTABE_CTA.AsString <> '') and (sqcVendasCODI_PSV.AsString <> '') then
             begin
                if (sqcVendasTCUS_TAB.AsString = '1') then
                    cust_mis := cust_mis + sqcVendasCTAB_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '2') then
                    cust_mis := cust_mis + sqcVendasCTAB_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '3') then
                    cust_mis := cust_mis + sqcVendasCMVD_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '4') then
                    cust_mis := cust_mis + sqcVendasCCPD_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '5') then
                    cust_mis := cust_mis + sqcVendasCGFI.Value;
             end;
          end;
          'S':
          begin
             {if chbAgrupaProdutos.Checked then
             begin
                if sqcVendasCEST_PRO.AsString = 'P' then
                   qtde_psv := qtde_psv - (sqcVendasQTDE_INO.Value * sqcVendasQTE1_PRO.Value)
                else if sqcVendasCEST_PRO.AsString = 'S' then
                   qtde_psv := qtde_psv - (sqcVendasQTDE_INO.Value * sqcVendasQTE2_PRO.Value * sqcVendasQTE1_PRO.Value)
                else
                   qtde_psv := qtde_psv - sqcVendasQTDE_INO.Value;
             end
             else}
                qtde_psv := qtde_psv - sqcVendasQTDE_INO.Value;

             tota_psv         := tota_psv       - sqcVendasVALORTOTAL.Value;
             cust_med         := cust_med       - sqcVendasCMVD_INO.Value;
             cust_tab         := cust_tab       - sqcVendasCTAB_INO.Value;
             cust_com         := cust_com       - sqcVendasCCPD_INO.Value;
             vlor_tab         := vlor_tab       - sqcVendasPVTB.Value;
             pis_psv          := pis_psv        - sqcVendasPIS.Value;
             cofins_psv       := cofins_psv     - sqcVendasCOFINS.Value;
             icms_psv         := icms_psv       - sqcVendasICMS.Value;
             cfin_psv         := cfin_psv       - sqcVendasCGFI.Value;
             comissao_vend1   := comissao_vend1 - sqcVendasCOMISSAO_VEND1.Value;
             comissao_vend2   := comissao_vend2 - sqcVendasCOMISSAO_VEND2.Value;
             comissao_total   := comissao_total - sqcVendasCOMISSAO_TOTAL.Value;
             despesas_frete   := despesas_frete - sqcVendasDESPESAS.Value;

             if (sqcVendasTABE_CTA.AsString <> '') and (sqcVendasCODI_PSV.AsString <> '') then
             begin
                if (sqcVendasTCUS_TAB.AsString = '1') then
                   cust_mis := cust_mis - sqcVendasCTAB_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '2') then
                   cust_mis := cust_mis - sqcVendasCTAB_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '3') then
                   cust_mis := cust_mis - sqcVendasCMVD_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '4') then
                   cust_mis := cust_mis - sqcVendasCCPD_INO.Value
                else
                if (sqcVendasTCUS_TAB.AsString = '5') then
                   cust_mis := cust_mis - sqcVendasCGFI.Value;
             end;
          end;
       end;

       sqcVendas.Delete;
    end;
end;

procedure TForm2.AddPsv2(demi: TDateTime; codi_emp: Integer; codi_pes, cod2_pes: Integer;
                codi_tra: Integer; codi_for: Integer; codi_gpr: Integer;
                codi_sbg: String; codi_tip: Integer; codi_ctf: Integer;
                codi_ctc: Integer; codi_psv, ccfo_cfo : String; codi_cul: Double;
                codi_rot: Integer; codi_reg: Integer; codi_mun: Integer;
                esta_mun: String; codi_cic, cond_con, codi_top: integer; doc_serie: string);
begin
     sqcTemp.Append;
     sqcTempDEMI.AsDateTime    := demi;
     sqcTempCODI_EMP.AsInteger := codi_emp;
     sqcTempCODI_PES.AsInteger := codi_pes;
     sqcTempCOD2_PES.AsInteger := cod2_pes;
     sqcTempCODI_TRA.AsInteger := codi_tra;
     sqcTempCODI_FOR.AsInteger := codi_for;
     sqcTempCODI_GPR.AsInteger := codi_gpr;
     sqcTempCODI_SBG.AsString  := codi_sbg;
     sqcTempCODI_TIP.AsInteger := codi_tip;
     sqcTempCODI_CTF.AsInteger := codi_ctf;
     sqcTempCODI_CTC.AsInteger := codi_ctc;
     sqcTempCODI_PSV.AsString  := codi_psv;
     sqcTempCODI_CUL.AsFloat   := codi_cul;
     sqcTempCODI_ROT.AsInteger := codi_rot;
     sqcTempCODI_REG.AsInteger := codi_reg;
     sqcTempCODI_MUN.AsInteger := codi_mun;
     sqcTempESTA_MUN.AsString  := esta_mun;
     sqcTempCODI_CIC.AsInteger := codi_cic;
     sqcTempCOND_CON.AsInteger := cond_con;
     sqcTempCCFO_CFO.AsString  := ccfo_cfo;
     sqcTempCODI_TOP.AsInteger := codi_top;
     sqcTempDOC_SERIE.AsString := doc_serie;

end;

end.

unit UdmRavin;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.UI, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs;

type
  TdmRavin = class(TDataModule)
    cnxBancoDeDados: TFDConnection;
    drvBancoDeDados: TFDPhysMySQLDriverLink;
    wtcBancoDeDados: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure cnxBancoDeDadosBeforeConnect(Sender: TObject);
    procedure cnxBancoDeDadosAfterConnect(Sender: TObject);
  private
    { Private declarations }
    procedure CriarTabelas();
    procedure InserirDados();
  public
    { Public declarations }
  end;

var
  dmRavin: TdmRavin;

implementation

uses UresourceUtils, UiniUtils;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmRavin.cnxBancoDeDadosAfterConnect(Sender: TObject);
var

  LCriarBaseDados : Boolean;
begin

  LCriarBAseDados := not FileExists ('C:\ProgramData\MySQL\MySQL ' +
                                   'Server 8.0\Data\ravin\pessoa.ibd');

  if LCriarBaseDados then
  begin
     CriarTabelas();
     InserirDados();
  end;
end;

procedure TdmRavin.cnxBancoDeDadosBeforeConnect(Sender: TObject);
var
  LCaminhoBaseDados: String;
  LCriarBaseDados: Boolean;
  begin
  LcaminhoBaseDados  :=TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.CAMINHO_BANCO);
  LCriarBAseDados := not FileExists(LcaminhoBaseDados, True);
  with cnxBancoDeDados do
  begin
    Params.Values['Serve']     := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.SERVIDOR_BANCO);
    Params.Values['User_Name'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.USUARIO_BANCO);
    Params.Values['Password']  := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.SENHA_BANCO);
    params.Values['DriverID']  := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.DRIVER_ID_BANCO);
    Params.Values['Port']      := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.PORTA_BANCO);

    if not LCriarBaseDados then
    begin
      Params.Values['DataBase'] := TIniUtils.lerPropriedade(TSECAO.BANCO, TPROPRIEDADE.NOME_BANCO);
    end;
 end;
end;

procedure TdmRavin.CriarTabelas;
begin
  try
    cnxBancoDeDados.ExecSQL(TresourceUtils.CarregarArquivoResource
    ('createTable.sql', 'RavinScripts'));
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

procedure TdmRavin.DataModuleCreate(Sender: TObject);
begin
  if not cnxBancoDeDados.connected then begin
    cnxBAncoDeDados.Connected := true;
  end;
end;

procedure TdmRavin.InserirDados;
begin
  try
    cnxBancoDeDados.StartTransaction();
    cnxbancoDeDados.ExecSQL(TResourceUtils.carregararquivoResource
     ('inserts.sql', 'RavinScripts'));
    cnxBancoDeDados.Commit();
  except
    on E: Exception do begin
      cnxBancoDeDados.Rollback();
      ShowMessage(E.Message);
    end;
  end;
end;
end.

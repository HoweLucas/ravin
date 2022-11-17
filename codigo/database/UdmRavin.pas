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

uses UresourceUtils;

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
  LcaminhoBaseDados  := 'C:\ProgramData\MySQL\MySQL Server 8.0' +
                                         '\Data\ravin\pessoa.ibd';
  LCriarBAseDados := not FileExists(LcaminhoBaseDados, True);
  with cnxBancoDeDados do
  begin
    Params.Values['Serve']     := 'localhost';
    Params.Values['User_Name'] := 'root';
    Params.Values['Password']  := 'root';
    params.Values['DriverID']  := 'MySQL';
    Params.Values['Port']      := '3306';

    if not LCriarBaseDados then
    begin
      Params.Values['DataBase'] := 'ravin';
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
  if cnxBancoDeDados.connected then begin
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

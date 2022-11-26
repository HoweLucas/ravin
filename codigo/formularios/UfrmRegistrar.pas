unit UfrmRegistrar;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,

  FireDAC.Phys.MySQLWrapper,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UfrmBotaoPrimario,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  System.Actions, Vcl.ActnList, Vcl.ExtActns;

type
  TfrmRegistrar = class(TForm)
    imgFundo: TImage;
    pnlRegistrar: TPanel;
    lblTituloRegistrar: TLabel;
    lblSubTituloRegistrar: TLabel;
    lblTituloAutenticar: TLabel;
    lblSubTituloAutenticar: TLabel;
    edtNome: TEdit;
    edtCpf: TEdit;
    frmBotaoPrimarioRegistrar: TfrmBotaoPrimario;
    edtLogin: TEdit;
    edtSenha: TEdit;
    edtConfirmarSenha: TEdit;
    procedure lblSubTituloAutenticarClick(Sender: TObject);
    procedure frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(Sender: TObject);
  private
    { Private declarations }
    procedure SetMainForm(NovoMainForm: TForm);
  public
    { Public declarations }
  end;

var
  frmRegistrar: TfrmRegistrar;

implementation

uses
  UusuarioDao,
  Uusuario,
  UfrmLogin,
  UvalidadorUsuario;

{$R *.dfm}

procedure TfrmRegistrar.frmBotaoPrimarioRegistrarspbBotaoPrimarioClick(
  Sender: TObject);
var
  Lusuario: Tusuario;
  LDao: TUsuarioDao;
begin
  try
   try

    Lusuario := Tusuario.create;
    LUsuario.Login := edtLogin.text;
    LUsuario.Senha := edtsenha.text;
    Lusuario.pessoaId :=10000;
    LUsuario.criadoPor := 'admin';
    lusuario.criadoEm  := Now();
    LUsuario.alteradoEm := Now();
    LUsuario.alteradoPor := 'admin';

    TValidadorUsuario.Validar(LUsuario, edtConfirmarsenha.text);

    LDao := TUsuarioDao.create();
    LDAo.inserirUsuario(LUsuario);

    freeAndNil(LDao);
     except
     on E : EMySQLNativeException do begin
     ShowMessage('Erro ao inserir o usuário no banco');
     end;

     on E: Exception do begin
     ShowMessage(e.Message);
     // Se tiver 1 ou mais de 'on', O exception deve ficar em ultimo
     end;
   end;
  finally
    if Assigned(LDAO) then
    begin
      FreeAndNil(LDAO);
    end;

    FreeAndNil(Lusuario);
  end;
 end;

procedure TfrmRegistrar.lblSubTituloAutenticarClick(Sender: TObject);
begin
 if not Assigned(frmLogin) then
 begin
   Application.CreateForm(TfrmLogin, frmLogin);
  end;

  SetMainForm(frmLogin);
  frmLogin.Show();

  Close();
end;

procedure TfrmRegistrar.SetMainForm(NovoMainForm: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := NovoMainForm;
end;

end.

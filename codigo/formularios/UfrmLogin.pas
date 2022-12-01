unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TFrmLogin = class(TForm)
    StaticText1: TStaticText;
    Panel1: TPanel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Label3: TLabel;
    labelTitulo: TLabel;
    lblLoguecontinuar: TLabel;
    Label2: TLabel;
    edtLogin: TEdit;
    Edtsenha: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses
  UfrmPainelGestao, UusuarioDao, Uusuario, UfrmRegistrar, UiniUtils, UFormUtils;

{$R *.dfm}

procedure TFrmLogin.Button1Click(Sender: TObject);
var
  LDao: TUsuarioDao;
  LUsuario: TUsuario;

  Llogin: String;
  Lsenha: string;
begin

  LUsuario := nil;
  LDao     := nil;

  Llogin := edtLogin.text;
  Lsenha := Edtsenha.text;

  LDao     := TUsuarioDao.create;
  LUsuario := LDao.BuscarUsuarioPorLoginSenha(Llogin, Lsenha);
  if Assigned(LUsuario) then
  begin
    // Registrando a data do ultimo login do usuário
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS,
      TPROPRIEDADE.DATAHORA_ULTIMO_LOGIN, DateTimeToStr(now()));

    // Registrar que o usuário efetuou o login com sucesso
    TIniUtils.gravarPropriedade(TSECAO.INFORMACOES_GERAIS, TPROPRIEDADE.LOGADO,
      TIniUtils.VALOR_VERDADEIRO);

    if not Assigned(frmPainelGestao) then
    begin
      application.CreateForm(tfrmpainelgestao, frmPainelGestao);
    end;
    TFormUtils.SetarFormularioPrincipal(frmPainelGestao);
    frmPainelGestao.Show();
    close;
  end

  else
  begin
    FreeAndNil(LDao);
    ShowMessage('Login e/ou senha inválidos');
  end;

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);
end;

procedure TFrmLogin.Button2Click(Sender: TObject);
var
  LUsuario : TUsuario;
  LDao     : TUsuarioDao;
begin
  LUsuario             := TUsuario.create();
  LUsuario.login       := 'teste';
  LUsuario.senha       := '123';
  LUsuario.PessoaId    := 1;
  LUsuario.criadoEm    := now();
  LUsuario.criadoPor   := 'marcio';
  LUsuario.alteradoEm  := now();
  LUsuario.alteradoPor := 'marcio';

  LDao := TUsuarioDao.create();
  LDao.InserirUsuario(LUsuario);

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);
end;

procedure TFrmLogin.Label3Click(Sender: TObject);
begin
  if not Assigned(frmRegistrar) then
  begin
    application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;

  TFormUtils.SetarFormularioPrincipal(frmRegistrar);
  frmRegistrar.Show();

  close();
end;

end.

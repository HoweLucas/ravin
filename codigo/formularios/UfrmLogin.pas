unit UfrmLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage ;

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
  LDao     : TUsuarioDao;
  LUsuario : TUsuario;

  Llogin: String;
  Lsenha: string;
begin

  LDao := TUsuarioDao.create;

  Llogin := EdtLogin.text;
  Lsenha := EdtSenha.text;

   LUsuario := LDao.BuscarUsuarioPorLoginSenha(LLogin, LSenha);

  if Assigned(LUsuario) then
  begin
    if not assigned(frmPainelGestao) then
    begin
      //Conseguiu logar

      TIniUtils.gravarPropriedade(
      TSECAO.INFORMACOES_GERAIS,
      TPROPRIEDADE.LOGADO, TIniUtils.VALOR_VERDADEIRO);

      if not Assigned(frmPainelGestao) then
      begin
        application.CreateForm(tfrmpainelgestao, frmpainelgestao);
      end;
    end;

    TFormUtils.SetarFormularioPrincipal(frmPainelGestao);
    frmpainelgestao.Show();

    close;
  end
  else
  begin
    FreeAndNil(LDao);
    ShowMessage('Login e/ou senha inválidos');
  end;
   freeAndNil ( LDao);
   freeAndNil ( LUsuario);
end;

procedure TFrmLogin.Button2Click(Sender: TObject);
var
 LUsuario: TUsuario;
 LDao : TUsuarioDao;
begin
  LUsuario := TUsuario.create();
  LUsuario.login := 'teste';
  Lusuario.senha := '123';
  Lusuario.PessoaId := 1;
  Lusuario.criadoEm := Now();
  Lusuario.criadoPor :='marcio';
  Lusuario.alteradoEm := Now();
  Lusuario.alteradoPor := 'marcio';

  LDao := TUsuarioDao.Create();
  Ldao.InserirUsuario(LUsuario);

  FreeAndNil(LDao);
  FreeAndNil(LUsuario);
end;

procedure TFrmLogin.Label3Click(Sender: TObject);
begin
 if not Assigned(frmRegistrar) then
 begin
   Application.CreateForm(TfrmRegistrar, frmRegistrar);
  end;

  TformUtils.SetarFormularioPrincipal  (frmRegistrar);
  frmRegistrar.Show();

  Close();
end;
end.

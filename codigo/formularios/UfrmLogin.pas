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
    procedure SetarFormPrincipal(PNovoFormulario: TForm);
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

uses
  UfrmPainelGestao, UusuarioDao, Uusuario, UfrmRegistrar;

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
    application.CreateForm(tfrmpainelgestao, frmpainelgestao);
    end;

    SetarFormPrincipal(frmPainelGestao);
    frmpainelgestao.Show();

    freeAndNil ( LDao);
    freeAndNil ( LUsuario);
    close();
  end else begin
    FreeAndNil(LDao);
    ShowMessage('Login e/ou senha inválidos');
  end;
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

  SetarFormPrincipal(frmRegistrar);
  frmRegistrar.Show();

  Close();
end;

procedure TFrmLogin.SetarFormPrincipal(PNovoFormulario: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain  := @Application.Mainform;
  tmpMain^ := PNovoFormulario;
end;
end.

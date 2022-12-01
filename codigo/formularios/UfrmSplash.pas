unit UfrmSplash;

interface

uses
  Winapi.Windows,
  Winapi.Messages,

  System.SysUtils,
  System.Variants,
  System.Classes,

  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,

  UfrmLogomarca;

type
  TfrmSplash = class(TForm)
    pnlFundo  : TPanel;
    tmrSplash : TTimer;
    frmLogo   : TfrmLogo;
    procedure tmrSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
  private
    { Private declarations }
    Inicialized: Boolean;
    procedure InicializarAplicacao();
    procedure ShowPainelGestao();
    procedure ShowLogin();
  public
    { Public declarations }
    function VerificarDeveLogar() : Boolean;

    //Numero máximo de dias que o usuário fica logado
    //sem precisar autenticar novamente
    const Max_Dias_Login : Integer = 5;
  end;

var
  frmSplash: TfrmSplash;

implementation

{$R *.dfm}

uses UfrmPainelGestao, UfrmLogin, UiniUtils, System.DateUtils, UFormUtils;

procedure TfrmSplash.FormCreate(Sender: TObject);
begin
  Inicialized        := false;
  tmrSplash.Enabled  := false;
  tmrSplash.Interval := 1000;
end;

procedure TfrmSplash.FormPaint(Sender: TObject);
begin
  tmrSplash.Enabled := not Inicialized;
end;

procedure TfrmSplash.InicializarAplicacao;
var
  LLogado       : String;
  LLoginExpirou : Boolean;
begin
  //Carregando se o usuário está logado
  LLogado := TIniUtils.lerPropriedade(TSECAO.INFORMACOES_GERAIS,
  TPropriedade.LOGADO);

  LLoginExpirou := VerificarDeveLogar();

  if (LLogado = TIniUtils.VALOR_VERDADEIRO)
  And(Not LLoginExpirou) then
  begin
    ShowPainelGestao();
  end
  else
  begin
    ShowLogin();
  end;
end;

procedure TfrmSplash.tmrSplashTimer(Sender: TObject);
begin
  tmrSplash.Enabled := false;
  if not Inicialized then
  begin
    Inicialized := true;
    InicializarAplicacao();
  end;
end;

function TfrmSplash.VerificarDeveLogar: Boolean;
var
  LDataString            : String;
  LDataUltimoLogin       : TDateTime;
  LDataExpiracaoLogin    : TDateTime;
  LExisteDataUltimoLogin : Boolean;
begin
  //Carregando a datahora do ultimo login do usuário
  LDataString := TIniUtils.lerPropriedade(
   TSECAO.INFORMACOES_GERAIS,
   TPropriedade.DATAHORA_ULTIMO_LOGIN);

  //Tenta converter a data do ultimo login para um DateTime
  // e retorna o sucesso dessa operação
  LExisteDataUltimoLogin := TryStrToDateTime(LDataString, LDataUltimoLogin);

   try
    //Convertendo a data de String para DateTime
    LdataUltimoLogin    := StrToDateTime(LDataString);
    //Calculando a data de expiração do login
    LDataExpiracaologin := IncDay(LDataUltimoLogin, Max_Dias_Login);

    Result := LDataExpiracaoLogin < Now();
    except
    on E: Exception do
    Result := True;
   end;


end;

procedure TfrmSplash.ShowLogin;
begin
  if not Assigned(frmLogin) then
    begin
    Application.CreateForm(TfrmLogin, frmLogin);
    end;


    TFormUtils.SetarFormularioPrincipal(frmLogin);
    frmLogin.Show();

    Close;

end;

procedure TfrmSplash.ShowPainelGestao;
begin
  if not Assigned(frmPainelGestao) then
  begin
    Application.CreateForm(TfrmPainelGestao, frmPainelGestao);
  end;

  TFormUtils.SetarFormularioPrincipal(frmPainelGestao);
  frmPainelGestao.Show();

  Close;
end;

end.



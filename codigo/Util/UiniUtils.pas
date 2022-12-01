unit UiniUtils;
interface
uses
  System.IOUtils,
  Vcl.Forms,
  TypInfo,
  IniFiles;
type
  TSECAO = (CONFIGURACOES, INFORMACOES_GERAIS, BANCO);
type
  TPROPRIEDADE = (LOGADO, DATAHORA_ULTIMO_LOGIN, SERVIDOR_BANCO, PORTA_BANCO, USUARIO_BANCO, SENHA_BANCO,
  NOME_BANCO, CAMINHO_BANCO,DRIVER_ID_BANCO);
  type
  TIniUtils = class
  private
  protected
  public
    constructor Create();
    destructor Destroy; override;
    class procedure gravarPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE; PValor: String);
    class function lerPropriedade(PSecao: TSECAO;
      PPropriedade: TPROPRIEDADE): String;
    const VALOR_VERDADEIRO: String = 'true';
    const VALOR_FALSO: String = 'false';
  end;
implementation
{ TIniUltis }

constructor TIniUtils.Create;
begin
  inherited;
end;
destructor TIniUtils.Destroy;
begin
  inherited;
end;
class procedure TIniUtils.gravarPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE; PValor: String);
var
  LcaminhoArquivoIni : String;
  LarquivoINI        : TIniFile;
  LNomeSecao         : String;
  LNomePropriedade   : String;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');

  LarquivoINI      := TIniFile.Create(LcaminhoArquivoIni);

  lNomeSecao       := GetENumName(TypeInfo(TSecao), Integer(PSecao));

  LNomePropriedade := GetEnumName(
  TypeInfo(TPROPRIEDADE), Integer(PPropriedade));

  LarquivoINI.WriteString(GetEnumName(TypeInfo(TSECAO), Integer(PSecao)),
    GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade)), PValor);

  LarquivoINI.WriteString(LNomeSecao, LNomePropriedade, PValor);

  LarquivoINI.Free;

end;
class function TIniUtils.lerPropriedade(PSecao: TSECAO;
  PPropriedade: TPROPRIEDADE): String;
var
  LcaminhoArquivoIni : String;
  LarquivoINI        : TIniFile;
  LNomesecao         : string;
  LNomePropriedade   : String;
begin
  LcaminhoArquivoIni := TPath.Combine(TPath.Combine(TPath.GetDocumentsPath,
    'ravin'), 'configuracoes.ini');
  LarquivoINI      := TIniFile.Create(LcaminhoArquivoIni);

  LNomeSecao       := GEtEnumName(TypeInfo(TSECAO), Integer(PSecao));

  LNomePropriedade := GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade));

  Result           := LarquivoINI.ReadString(GetEnumName
  (TypeInfo(TSECAO), Integer(PSecao) ),
   GetEnumName(TypeInfo(TPROPRIEDADE), Integer(PPropriedade)), '');

  LarquivoINI.Free;
end;
end.

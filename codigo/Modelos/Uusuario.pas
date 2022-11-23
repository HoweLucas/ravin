unit Uusuario;

interface

type TUsuario = class
  private
    Fid: Integer;
    FLogin: String;
    FSenha: String;
    FpessoaId: Integer;
    FcriadoEm: TDateTime;
    FalteradoEm: TDateTime;
    FcriadoPor: String;
    FalteradoPor: String;



  protected

  public
  property id: Integer read Fid write Fid;
  property Login: String read FLogin write FLogin;
  property Senha: String read FSenha write FSenha;
  property pessoaId: Integer read FpessoaId write FpessoaId;
  property criadoEm: TDateTime read FcriadoEm write FcriadoEm;
  property criadoPor: String read FcriadoPor write FcriadoPor;
  property alteradoEm: TDateTime read FalteradoEm write FalteradoEm;
  property alteradoPor: String read FalteradoPor write FalteradoPor;

end;

implementation

end.

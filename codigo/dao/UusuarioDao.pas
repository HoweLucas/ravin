unit UusuarioDao;

interface

uses
system.SysUtils,
Uusuario,
FireDAC.Comp.Client;

type TUsuarioDao = class
  private

  protected

  public
  function BuscarUsuarioPorLoginSenha (
       PLogin: String; PSenha:String) : TUsuario;
  procedure InserirUsuario(PUsuario: TUsuario);

end;



implementation


{ TUsuarioDao }

uses UdmRavin;

function TUsuarioDao.BuscarUsuarioPorLoginSenha(PLogin,
  PSenha: String): TUsuario;

var
  LQuery   : TFDQuery;
  LUsuario : TUsuario;
begin
  LQuery := TFDQuery.Create(nil);
  LQuery.connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text   := ' SELECT * From Usuario ' +
      ' Where login = : login AND senha = :senha ';
  lQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := Psenha;
  Lquery.Open();

  LUsuario := nil;

  if not LQuery.IsEmpty then begin
      //Achou algum registro
      LUsuario             := TUsuario.create();
      LUsuario.id          := LQuery.FieldByName('id').AsInteger;
      LUsuario.login       := LQuery.FieldByName('login').AsString;
      LUsuario.senha       := LQuery.FieldByName('senha').AsString;
      LUsuario.pessoaId    := LQuery.FieldByName('pessoaId').AsInteger;
      LUsuario.criadoEm    := Lquery.FieldByName('criadoEm').AsDateTime;
      LUsuario.criadoPor   := LQuery.FieldByName('criadoPor').AsString;
      LUsuario.alteradoEm  := LQuery.FieldByName('alteradiEm').AsdateTime;
      LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.close();
  FreeAndNil(LQuery);
  Result := LUsuario;

end;
procedure TUsuarioDao.InserirUsuario(PUsuario: TUsuario);
Var
  Lquery: TFDQuery;
begin
  Lquery := TFDQuery.create(nil);
  with LQuery do
  begin
    Connection := dmRavin.cnxBancoDeDados;
    SQL.add('INSERT INTO usuario ');
    SQL.add(' (login, senha, pessoaId,');
    SQL.add('criadoEm, CriadoPor, alteradoEm, alteradoPor)');
    SQL.add(' VALUES (:login, :senha, :pessoaID');
    SQL.add(' :criadoEm, :criadoPor, :alteradoEm, :alteradoPor)');

    ParamByName('login').AsString := Pusuario.login;
    ParamByName('senha').AsString := PUsuario.senha;
    ParamByName('pessoaId').AsInteger := PUsuario.pessoaId;
    paramByName('criadoEm').AsDateTime :=Pusuario.criadoEm;
    paramByname('criadoPor').AsString := PUsuario.criadoPor;
    paramByName('alteradoEm').AsDateTime := Pusuario.alteradoEm;
    parambyname('alteradoPor').AsString := PUsuario.alteradoPor;
    execSQL();
  end;

  FreeAndNil(LQuery);

end;

end.

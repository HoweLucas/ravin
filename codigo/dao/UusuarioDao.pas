unit UusuarioDao;

interface

uses
system.SysUtils,
Uusuario,
Generics.Collections,
FireDAC.Comp.Client;

type TUsuarioDao = class
  private

  protected

  public
  function BuscarTodosUsuarios : TList<TUsuario>;

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
  LQuery.SQL.Text   := 'Select * from Usuario ' +
     'where login = :login AND senha = :senha';
  LQuery.ParamByName('login').AsString := PLogin;
  LQuery.ParamByName('senha').AsString := PSenha;
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
      LUsuario.alteradoEm  := LQuery.FieldByName('alteradoEm').AsdateTime;
      LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;
  end;

  LQuery.close();
  FreeAndNil(LQuery);
  Result := LUsuario;

end;



function TUsuarioDao.BuscarTodosUsuarios: TList<TUsuario>;
var
  LLista       : TList<TUsuario>;
  LUsuario     : TUsuario;
  LQuery       : TFDQuery;

begin
  LQuery            := TFDQuery.Create(nil);
  LQuery.Connection := dmRavin.cnxBancoDeDados;
  LQuery.SQL.Text   := 'Select * from Usuario';
  LQuery.Open();

  LQuery.First;

while not LQuery.Eof do
 Begin

   LUsuario             := TUsuario.create();
   LUsuario.id          := LQuery.FieldByName('id').AsInteger;
   LUsuario.login       := LQuery.FieldByName('login').AsString;
   LUsuario.senha       := LQuery.FieldByName('senha').AsString;
   LUsuario.pessoaId    := LQuery.FieldByName('pessoaId').AsInteger;
   LUsuario.criadoEm    := Lquery.FieldByName('criadoEm').AsDateTime;
   LUsuario.criadoPor   := LQuery.FieldByName('criadoPor').AsString;
   LUsuario.alteradoEm  := LQuery.FieldByName('alteradoEm').AsdateTime;
   LUsuario.alteradoPor := LQuery.FieldByName('alteradoPor').AsString;

   LLista.Add(LUsuario);
   LQuery.Next;
   end;

 Result := LLista;
 FreeAndNil(LQuery);

End;



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

    ParamByName('id').asInteger := PUsuario.id;
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

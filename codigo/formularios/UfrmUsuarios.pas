unit UfrmUsuarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.Classes, Generics.Collections;

type
  Tbntcarregar = class(TForm)
    memListaUsers: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  bntcarregar: Tbntcarregar;

implementation

uses
  UusuarioDao, Uusuario;

{$R *.dfm}

procedure Tbntcarregar.Button1Click(Sender: TObject);
var
  LDao: TUsuarioDao;
  Lusuario: TUsuario;
  LLista  : TList<TUsuario>;
  I : Integer;
begin

  LDAO := TUsuarioDao.Create();
  lLista := LDAo.BuscarTodosUsuarios();

  for I := 0 to LLista.Count - 1 do
  begin
    LUsuario := LLista.Items[I];
    memListaUsers.Lines.Add(LUsuario.Login);
    FreeAndNil(Lusuario);

    FreeAndNil(LDAO);
    FreeAndNil(LLista);
  end;

end;

end.

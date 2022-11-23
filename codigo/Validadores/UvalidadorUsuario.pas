unit UvalidadorUsuario;

interface

uses
System.StrUtils,
System.SysUtils,
Uusuario;

type TValidadorUsuario = class
  private

  protected

  public
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirma��o : String);
end;

implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario;
 PSenhaConfirma��o: string);

begin
   // Nome n�o pode ser vazio
   // Login n�o pode ser vazio
   // CPF � vazio
   // Quantidade de caracteres do login
   // S� numero no CPF
   // Nome n�o pode aceitar numero
   // Validar caracteres especiais nos campos
   // CPF n�o pode ser vazio
   // Senha = Confirma��o Senha
   // CPF � valido

   if PUsuario.Login.IsEmpty then
   begin
     raise Exception.Create('O campo login n�o pode ser vazio');
   end;

   if Pusuario.senha.IsEmpty then
   begin
     raise Exception.Create('O camp� senha n�o pode ser vazio');
   end;

   if Pusuario.senha <> PSenhaConfirma��o then
   begin
     raise Exception.Create('A senha e a confirma��o devem ser iguais');
   end;


end;

end.

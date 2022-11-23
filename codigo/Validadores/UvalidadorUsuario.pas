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
  class procedure Validar(PUsuario: TUsuario; PSenhaConfirmação : String);
end;

implementation

{ TValidadorUsuario }

class procedure TValidadorUsuario.Validar(PUsuario: TUsuario;
 PSenhaConfirmação: string);

begin
   // Nome não pode ser vazio
   // Login não pode ser vazio
   // CPF é vazio
   // Quantidade de caracteres do login
   // Só numero no CPF
   // Nome não pode aceitar numero
   // Validar caracteres especiais nos campos
   // CPF não pode ser vazio
   // Senha = Confirmação Senha
   // CPF é valido

   if PUsuario.Login.IsEmpty then
   begin
     raise Exception.Create('O campo login não pode ser vazio');
   end;

   if Pusuario.senha.IsEmpty then
   begin
     raise Exception.Create('O campó senha não pode ser vazio');
   end;

   if Pusuario.senha <> PSenhaConfirmação then
   begin
     raise Exception.Create('A senha e a confirmação devem ser iguais');
   end;


end;

end.

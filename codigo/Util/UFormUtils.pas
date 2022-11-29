unit UFormUtils;

interface
uses
vcl.Forms,
system.SysUtils;

type
 TFormUtils = class
   private

   protected

   public

 class procedure SetarFormularioPrincipal(PNovoFormularioPricipal: TForm);
 end;

implementation

{ TSetarFormPrincipal }

Class procedure TFormUtils.SetarFormularioPrincipal(
  PNovoFormularioPricipal: TForm);
var
  tmpMain: ^TCustomForm;
begin
  tmpMain := @Application.Mainform;
  tmpMain^ := PNovoFormularioPricipal;
end;
end.

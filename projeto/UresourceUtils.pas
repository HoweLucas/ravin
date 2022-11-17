unit UresourceUtils;

interface

uses
  system.SysUtils,
  system.IOUtils,
  system.Classes;

type
  TResourceUtils = class(Tobject)
  private

  protected

  public

 class   function carregarArquivoResource(PNomeArquivo: String;
      PNomeAplicacao: String): String;
  end;

implementation

{ TResourceUtils }

class function TResourceUtils.carregarArquivoResource(PNomeArquivo: String;
  PNomeAplicacao: String): string;
var
  LConteudoArquivo: TstringList;
  LCaminhoArquivo: string;
  LCaminhoPastaAplicacao: String;
  LconteudoTexto: String;

begin
  LConteudoArquivo := TstringList.create();
  LconteudoTexto := '';
    try
      try
        LCaminhoPastaAplicacao := TPath.combine(TPath.GetDocumentsPath,
                                                       PNomeAplicacao);

        LCaminhoArquivo := TPath.combine(LCaminhoPastaAplicacao, PNomeArquivo);

        LConteudoArquivo.LoadFromFile(LCaminhoArquivo);

        lconteudoTexto := LConteudoArquivo.Text;

      except
        on E: Exception do
          raise Exception.create('Error ao arquivo de resource.' + 'Arquivo:   '
            + PNomeArquivo);
      end;
    finally
       LconteudoArquivo.free;
    end;

    Result := LConteudoTexto;

end;
end.

unit PandaSyntax;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Memo1: TMemo;
    procedure PandaSyntax(url: string; Memo: string; mascara: char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

procedure TForm1.PandaSyntax(url: string; Memo: string; mascara: char);
// A URL � o link onde est� o arquivo de texto e memo, o nome da memo que ser� armazenada (Por Exemplo: Memo1)
var
  IdHTTP: TIdHTTP; // Cria o IdHttp que vai fazer conex�o ao seu website
  nomeclean, strbruta: string; // Variaveis tempor�rias para formata��o
  i: integer;
  escreve: TMemo;
begin
  escreve := FindComponent(Memo) as TMemo;
  // Vai procurar pela string o componente com esse mesmo nome
  IdHTTP := TIdHTTP.Create(nil);
  try
    strbruta := (IdHTTP.Get(url));
    for i := 0 to length(strbruta) do // Loop que vai percorrer a string
    begin
      if copy(strbruta, i, 1) <> mascara then
      // Vai percorrendo e copiando tudo que n�o for o caractere de m�scara que no caso � a flag do PandaSyntax
      begin
        nomeclean := nomeclean + copy(strbruta, i, 1);
        // Atribui a vari�vel nomeclean caractere por caractere diferente da flag mascara
      end
      else
      begin
        escreve.Lines.Add(trim(nomeclean));
        // Adiciona uma linha nova a Memo, onde ficar� a frase j� formatada (Assim cada frase ou texto entre �* *� ficara em linhas separadas um do outro
        nomeclean := ''; // Limpa o valor de nomeclean
        escreve.Text := trim(escreve.Text)
        // Ele fazer o trim, para se certificar que a Memo n�o vai ter espa�os indesejados
      end;
    end;
  finally
    IdHTTP.Free;
  end;
end;

end.

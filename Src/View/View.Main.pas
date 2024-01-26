unit View.Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TVwMain = class(TForm)
    btnCategoria: TButton;
    procedure btnCategoriaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VwMain: TVwMain;

implementation

{$R *.dfm}

uses View.Categoria;

procedure TVwMain.btnCategoriaClick(Sender: TObject);
begin
  VwCategoria := TVwCategoria.Create(Self);
  try
    VwCategoria.ShowModal;
  finally
    FreeAndNil(VwCategoria);
  end;
end;

end.

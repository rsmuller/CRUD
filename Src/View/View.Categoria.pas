unit View.Categoria;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, View.Padrao, Data.DB, Vcl.DBCtrls,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Mask;

type
  TVwCategoria = class(TVwPadrao)
    DBEdit1: TDBEdit;
    LabelDescricao: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  VwCategoria: TVwCategoria;

implementation

{$R *.dfm}

procedure TVwCategoria.FormCreate(Sender: TObject);
begin
  inherited;
  Tabela := 'CATEGORIA';
end;

end.

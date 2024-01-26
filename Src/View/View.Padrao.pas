unit View.Padrao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Data.DB, Vcl.StdCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,Controller.Conexao, Controller.Interfaces,
  Vcl.DBCtrls;

type
  TTipoOperacao = (opEditar, opConsultar);

  TVwPadrao = class(TForm)
    PageControl: TPageControl;
    tsConsulta: TTabSheet;
    tsDados: TTabSheet;
    PanelTopo: TPanel;
    GridConsulta: TDBGrid;
    EditId: TEdit;
    EditDescricao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ButtonConsulta: TButton;
    ButtonDeleta: TButton;
    ButtonFecha: TButton;
    dsConsulta: TDataSource;
    PanelBotoes: TPanel;
    PanelDados: TPanel;
    ButtonNovo2: TButton;
    ButtonNovo: TButton;
    ButtonEdita: TButton;
    ButtonCancela: TButton;
    ButtonConfirma: TButton;
    BtnFecha2: TButton;
    dsRegistro: TDataSource;
    Shape22: TShape;
    Label5: TLabel;
    DBText2: TDBText;
    procedure ButtonFechaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ButtonNovo2Click(Sender: TObject);
    procedure ButtonNovoClick(Sender: TObject);
    procedure ButtonEditaClick(Sender: TObject);
    procedure ButtonCancelaClick(Sender: TObject);
    procedure ButtonConfirmaClick(Sender: TObject);
    procedure BtnFecha2Click(Sender: TObject);
    procedure ButtonConsultaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GridConsultaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ButtonDeletaClick(Sender: TObject);
    procedure EditIdKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EditDescricaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditIdKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    FController : iController;
    FTabela     : String;
    FOperacao   : TTipoOperacao;
    procedure Consulta; virtual;
    procedure PosicionaRegistro(PId : Integer); virtual;
    procedure Valida; virtual;
    function Persistiu : Boolean; virtual;
    procedure ConfiguraAbas;
    procedure ConfiguraBotoes;
    procedure Insere;
    procedure Altera;
    procedure Cancela;
    procedure Confirma;
    procedure Deleta;
  public
    { Public declarations }
    property Tabela: String read FTabela write FTabela;
  end;

var
  VwPadrao: TVwPadrao;

implementation

{$R *.dfm}

procedure TVwPadrao.Altera;
begin
  if not dsRegistro.DataSet.Active then
    raise Exception.Create('Selecione um registro.');

  if dsRegistro.DataSet.FieldByName('ID').AsInteger > 0 then
    begin
      dsRegistro.DataSet.Edit;
      FOperacao          := opEditar;
      ConfiguraBotoes;
      SelectNext(PanelDados, True, True );
    end;
end;

procedure TVwPadrao.BtnFecha2Click(Sender: TObject);
begin
  FOperacao := opConsultar;
  ConfiguraAbas;
end;

procedure TVwPadrao.ButtonNovoClick(Sender: TObject);
begin
  Insere;
end;

procedure TVwPadrao.ButtonConsultaClick(Sender: TObject);
begin
  Consulta;
end;

procedure TVwPadrao.ButtonDeletaClick(Sender: TObject);
begin
  Deleta;
end;

procedure TVwPadrao.ButtonFechaClick(Sender: TObject);
begin
  Close;
end;

procedure TVwPadrao.ButtonNovo2Click(Sender: TObject);
begin
  Insere;
end;

procedure TVwPadrao.ButtonEditaClick(Sender: TObject);
begin
  Altera;
end;

procedure TVwPadrao.ButtonCancelaClick(Sender: TObject);
begin
  Cancela;
end;

procedure TVwPadrao.ButtonConfirmaClick(Sender: TObject);
begin
  Confirma;
end;

procedure TVwPadrao.Cancela;
begin
  dsRegistro.DataSet.Cancel;
  dsRegistro.DataSet.Close;
  ConfiguraBotoes;
  BtnFecha2.SetFocus;
end;

procedure TVwPadrao.ConfiguraAbas;
begin
  case FOperacao of
    opConsultar : begin
                    PageControl.ActivePage := tsConsulta;
                    if dsConsulta.DataSet <> nil then
                      dsConsulta.DataSet.Refresh;
                  end;
    opEditar    : PageControl.ActivePage := tsDados;
  end;
end;

procedure TVwPadrao.ConfiguraBotoes;
var
  i : Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    begin
      if (Self.Components[i] is TButton) then
        begin
          if (Self.Components[i] as TButton).Tag = 1 then
            (Self.Components[i] as TButton).Enabled := not (Self.Components[i] as TButton).Enabled;
        end
      else
      if (Self.Components[i] is TPanel) then
        begin
          if (Self.Components[i] as TPanel).Tag = 1 then
            (Self.Components[i] as TPanel).Enabled := not (Self.Components[i] as TPanel).Enabled;
        end;
    end;

end;

procedure TVwPadrao.Confirma;
begin
  Valida;

  if Persistiu then
  begin
    PosicionaRegistro(dsRegistro.DataSet.FieldByName('ID').AsInteger);
    ConfiguraBotoes;
    SelectNext(PanelBotoes, True, True );
  end;

end;

procedure TVwPadrao.Consulta;
var
  AFiltro : String;
begin
  AFiltro := EmptyStr;

  if EditId.Text <> EmptyStr then
    AFiltro := AFiltro + ' AND ID = ' + EditId.Text;

  if EditDescricao.Text <> EmptyStr then
    AFiltro := AFiltro + ' AND DESCRICAO LIKE ' + QuotedStr('%'+EditDescricao.Text+'%');

  FController
   .Entidades
    .Generica
     .Open(dsConsulta,FTabela,AFiltro);
end;

procedure TVwPadrao.Deleta;
begin
  if dsConsulta.DataSet <> nil then
  begin
    if not (dsConsulta.DataSet.FieldByName('ID').AsInteger > 0) then
      raise Exception.Create('Selecione um registro');

    if MessageDlg('Você deseja continuar?', mtConfirmation, mbYesNo, 0) = mrYes then
      begin
        FController
         .Entidades
          .Generica
           .Delete(FTabela,dsConsulta.DataSet.FieldByName('ID').AsString);

        dsConsulta.DataSet.Refresh;
      end;
  end;
end;

procedure TVwPadrao.EditDescricaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Consulta;
end;

procedure TVwPadrao.EditIdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Consulta;
end;

procedure TVwPadrao.EditIdKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8]) then
    Key := #0;
end;

procedure TVwPadrao.FormCreate(Sender: TObject);
begin
  FController := TController.New;
end;

procedure TVwPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (Key = VK_ESCAPE) then
  begin
    if (PageControl.ActivePage = tsConsulta) then
      Close
    else
    if (PageControl.ActivePage = tsDados) and not (dsRegistro.State in dsEditModes) then
    begin
      FOperacao := opConsultar;
      ConfiguraAbas;
    end;
  end;

  if (Key = VK_F1) and not (dsRegistro.State in dsEditModes) then
    Insere;

  if (Key = VK_F3) and not (dsRegistro.State in dsEditModes) then
    Altera;

  if (Key = VK_F5) then
  begin
   if (PageControl.ActivePage = tsConsulta) then
     Consulta
   else
   begin
     if (dsRegistro.State in dsEditModes) then
       Confirma;
   end;
  end;
end;

procedure TVwPadrao.FormShow(Sender: TObject);
begin
  tsConsulta.TabVisible := False;
  tsDados.TabVisible    := False;
  PageControl.ActivePageIndex := 0;
  SelectNext(PanelTopo, True, True );
end;

procedure TVwPadrao.GridConsultaDblClick(Sender: TObject);
begin
  if dsConsulta.DataSet <> nil then
  begin
    if dsConsulta.DataSet.FieldByName('ID').AsInteger > 0 then
    begin
      PosicionaRegistro(dsConsulta.DataSet.FieldByName('ID').AsInteger);
      FOperacao := opEditar;
      ConfiguraAbas;
    end;
  end;
end;

procedure TVwPadrao.Insere;
begin
  PosicionaRegistro(0);
  dsRegistro.DataSet.Append;

  dsRegistro.DataSet.FieldByName('ID').AsInteger  := 0;

  FOperacao          := opEditar;
  ConfiguraAbas;
  ConfiguraBotoes;
  SelectNext(PanelDados, True, True );
end;

function TVwPadrao.Persistiu: Boolean;
begin
  Result := FController
             .Entidades
              .Generica
               .Save(dsRegistro);
end;

procedure TVwPadrao.PosicionaRegistro(PId: Integer);
begin
  FController
   .Entidades
    .Generica
     .Open(dsRegistro,FTabela,' AND ID = ' + PId.ToString);
end;

procedure TVwPadrao.Valida;
begin
// implementar validações
end;

end.

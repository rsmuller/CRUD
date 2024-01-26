unit Model.Conexao;

interface

uses
  System.SysUtils,FireDAC.Comp.Client, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.SQLiteDef, FireDAC.VCLUI.Wait, Data.DB, FireDAC.DApt,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.SQLiteWrapper.Stat,
  Model.Interfaces;

type
  TModelConexaoERP = class(TInterfacedObject, iConexao)
  private
    FConexao : TFDConnection;
    FTransaction : TFDTransaction;
  public
    constructor Create;
    destructor Destroy; override;
    class function New : iConexao;
    function Connection : TObject;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

var
  Instancia: iConexao = nil;

implementation

{ TConexao }

procedure TModelConexaoERP.Commit;
begin
  FConexao.Commit;
end;

function TModelConexaoERP.Connection: TObject;
begin
  Result := FConexao;
end;

constructor TModelConexaoERP.Create;
begin
  FTransaction               := TFDTransaction.Create(nil);

  FConexao                   := TFDConnection.Create(nil);
  FConexao.FetchOptions.Mode := fmAll;
  FConexao.Transaction       := FTransaction;
  FConexao.Params.DriverID   := 'SQLite';
  with FConexao.Params as TFDPhysSQLiteConnectionDefParams do
  begin
    SharedCache := False;
    Database    := GetCurrentDir + '\DB\CRUD.s3db';
  end;
  FConexao.Connected         := true;
end;

destructor TModelConexaoERP.Destroy;
begin
  FreeAndNil(FConexao);
  FreeAndNil(FTransaction);
  inherited;
end;

class function TModelConexaoERP.New: iConexao;
begin
  if (Instancia = nil) then
    Instancia := Self.Create;
  Result := Instancia;
end;

procedure TModelConexaoERP.Rollback;
begin
  FConexao.Rollback;
end;

procedure TModelConexaoERP.StartTransaction;
begin
  FConexao.StartTransaction;
end;

end.

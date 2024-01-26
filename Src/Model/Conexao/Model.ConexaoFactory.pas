unit Model.ConexaoFactory;

interface

uses
  Model.Conexao, Model.Interfaces;

type
  TModelConexaoFactory = class(TInterfacedObject,iConexaoFactory)
    private
      FModelConexaoERP    : iConexao;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : iConexaoFactory;
      function ConexaoERP : iConexao;
  end;

implementation

{ TModelConexaoFactory }

function TModelConexaoFactory.ConexaoERP: iConexao;
begin
  if not Assigned(FModelConexaoERP) then
    FModelConexaoERP := TModelConexaoERP.New;
  Result := FModelConexaoERP;
end;

constructor TModelConexaoFactory.Create;
begin

end;

destructor TModelConexaoFactory.Destroy;
begin

  inherited;
end;

class function TModelConexaoFactory.New: iConexaoFactory;
begin
  Result := Self.Create;
end;

end.

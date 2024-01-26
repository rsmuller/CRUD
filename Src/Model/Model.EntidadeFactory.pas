unit Model.EntidadeFactory;

interface

uses
  System.SysUtils,
  Data.DB,
  Model.Interfaces;

type
  TModelEntidadeFactory = class(TInterfacedObject, iEntidadeFactory)
  private
    FConexao           : iConexao;
    FGenerica          : iEntidade;
  public
    constructor Create(AConexao : iConexao);
    destructor Destroy; override;
    class function New(AConexao : iConexao) : iEntidadeFactory;
    function Generica : iEntidade;
  end;

implementation

{ TModelEntidadeFactory }

uses Model.EntidadeGenerica;


function TModelEntidadeFactory.Generica: iEntidade;
begin
  if not Assigned(FGenerica) then
    FGenerica := TModelEntidadeGenerica.New(FConexao);
  Result := FGenerica;
end;

constructor TModelEntidadeFactory.Create(AConexao : iConexao);
begin
  FConexao := AConexao;
end;

destructor TModelEntidadeFactory.Destroy;
begin

  inherited;
end;

class function TModelEntidadeFactory.New(AConexao : iConexao): iEntidadeFactory;
begin
  Result := Self.Create(AConexao);
end;

end.

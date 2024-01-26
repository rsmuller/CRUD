unit Controller.Conexao;

interface

uses
  System.SysUtils,
  System.Variants,
  Controller.Interfaces,
  Model.Interfaces;

type
  TController = class(TInterfacedObject, iController)
  private
     FConexao           : iConexaoFactory;
     FModelEntidades    : iEntidadeFactory;
     FSessao            : iSessao;
  public
     constructor Create;
     destructor Destroy; override;
     class function New : iController;
     function Entidades : iEntidadeFactory;
     function Sessao    : iSessao;
  end;

implementation

{ TControllerEntidadePadrao }

uses
   Model.ConexaoFactory,
   Model.EntidadeFactory,
   Model.Sessao;

destructor TController.Destroy;
begin
  inherited;
end;

function TController.Entidades: iEntidadeFactory;
begin
  if not Assigned(FModelEntidades) then
    FModelEntidades := TModelEntidadeFactory.New(FConexao.ConexaoERP);
  Result := FModelEntidades;
end;

class function TController.New: iController;
begin
  Result := Self.Create;
end;

function TController.Sessao: iSessao;
begin
  Result := TModelSessao.ObterSessao;
end;

constructor TController.Create;
begin
  FConexao   := TModelConexaoFactory.New;
end;

end.

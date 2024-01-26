unit Model.Sessao;

interface

uses
  System.SysUtils,
  Model.Interfaces;

type
  TModelSessao = class(TInterfacedObject, iSessao)
  private
    FIdUsuario       : Integer;
    FAdmin           : Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    class function ObterSessao: iSessao;
    function SetIdUsuario(AIdUsuario : Integer) : iSessao;
    function SetAdmin(aAdmin : Boolean) : iSessao;
    function GetIdUsuario : Integer;
    function GetAdmin : Boolean;
  end;

var
  Instancia: iSessao = nil;

implementation

constructor TModelSessao.Create;
begin
end;

destructor TModelSessao.Destroy;
begin
  inherited;
end;

function TModelSessao.GetAdmin: Boolean;
begin
  Result := FAdmin;
end;

function TModelSessao.GetIdUsuario: Integer;
begin
  Result := FIdUsuario;
end;

class function TModelSessao.ObterSessao: iSessao;
begin
  if (Instancia = nil) then
    Instancia := Self.Create;

  Result := Instancia;
end;

function TModelSessao.SetAdmin(aAdmin: Boolean) : iSessao;
begin
  Result := Self;
  FAdmin := aAdmin;
end;


function TModelSessao.SetIdUsuario(AIdUsuario : Integer) : iSessao;
begin
  Result     := Self;
  FIdUsuario := AIdUsuario;
end;

end.

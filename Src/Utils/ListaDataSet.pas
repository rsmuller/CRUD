unit ListaDataSet;

interface

uses
  Data.DB,
  Model.Interfaces,
  System.SysUtils,
  System.Generics.Collections,
  Model.Query;

type
  TListaDataSet = class
  private
    FListaDataSet       : TDictionary<String,iQuery>;
    FConexao            : iConexao;
  public
    constructor Create(AConexao : iConexao);
    destructor Destroy; override;
    procedure SelecionaQuery(ANome : String;var ADataSet : iQuery);
  end;

implementation

constructor TListaDataSet.Create(AConexao : iConexao);
begin
  FConexao      := AConexao;
  FListaDataSet := TDictionary<String,iQuery>.Create;
end;

destructor TListaDataSet.Destroy;
begin
  FreeAndNil(FListaDataSet);
  inherited;
end;

procedure TListaDataSet.SelecionaQuery(ANome : String;var ADataSet : iQuery);
begin
  if not FListaDataSet.ContainsKey(aNome) then
    begin
     ADataSet      := TModelQuery.New(FConexao,True);
     FListaDataSet.Add(aNome, ADataSet);
    end;

  FListaDataSet.TryGetValue(aNome, ADataSet);
end;

end.

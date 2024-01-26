unit Model.EntidadeGenerica;

interface

uses
  Data.DB,
  System.Variants,
  Model.Query,
  System.SysUtils,
  Model.Interfaces,
  ListaDataSet,
  System.StrUtils;

type
  TModelEntidadeGenerica = class(TInterfacedObject,iEntidade)
  private
    FListaDataSet       : TListaDataSet;
    FConexao            : iConexao;
    FDataSet,
    FQuery              : iQuery;
  public
    property ListaDataSet: TListaDataSet read FListaDataSet write FListaDataSet;
    property Conexao: iConexao read FConexao write FConexao;

    constructor Create(aConexao : iConexao);
    destructor Destroy; override;
    class function New(aConexao : iConexao) : iEntidade;
    procedure Open(PDataSource : TDataSource; PTabela, PFiltro : String);
    procedure Delete(PTabela, PId : String);
    function  Save(PDataSource : TDataSource) : Boolean;

  end;

implementation

constructor TModelEntidadeGenerica.Create(aConexao : iConexao);
begin
  FConexao          := aConexao;
  FQuery            := TModelQuery.New(FConexao);

  FDataSet          := TModelQuery.New(FConexao,True);
  FListaDataSet     := TListaDataSet.Create(FConexao);
end;

destructor TModelEntidadeGenerica.Destroy;
begin
  FreeAndNil(FListaDataSet);
  inherited;
end;

procedure TModelEntidadeGenerica.Delete(PTabela, PId : String);
begin
  FConexao.StartTransaction;
  try
    FQuery.Add('DELETE FROM '+ PTabela +' WHERE ID = '+ PId);
    FQuery.ExecSQL;

    FConexao.Commit;
  except
    on E: Exception do
      begin
        FConexao.Rollback;
        raise Exception.Create(E.Message);
      end;
  end;
end;

class function TModelEntidadeGenerica.New(aConexao : iConexao): iEntidade;
begin
  Result := Self.Create(aConexao);
end;

procedure TModelEntidadeGenerica.Open(PDataSource : TDataSource; PTabela, PFiltro : String);
var
  ASql : String;
begin
  ASql      := EmptyStr;

  FListaDataSet.SelecionaQuery(PDataSource.Name,FDataSet);

  ASql      := 'SELECT * '+
               ' FROM ' + PTabela +
               ' WHERE ID > 0 ' + PFiltro;

  FDataSet.Add(ASql);
  FDataSet.Open();

  PDataSource.DataSet := TDataSet(FDataSet.Query);
end;

function TModelEntidadeGenerica.Save(PDataSource : TDataSource): Boolean;
var
  i          : Integer;
begin
  FListaDataSet.SelecionaQuery(PDataSource.Name,FDataSet);

  FConexao.StartTransaction;
  try
    if PDataSource.DataSet.State in dsEditModes then
      FDataSet.Post;

    FDataSet.ApplyUpdates;

    FListaDataSet.SelecionaQuery(PDataSource.Name,FDataSet);

    FConexao.Commit;
    Result := True;
  except
  on E: Exception do
    begin
      Result := False;
      FConexao.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;

end;

end.

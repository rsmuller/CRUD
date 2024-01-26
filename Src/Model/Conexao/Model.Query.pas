unit Model.Query;

interface

uses
  Model.Conexao,
  FireDAC.Comp.Client,
  FireDAC.Stan.Error,
  System.SysUtils,
  Data.DB,
  System.Classes,
  System.Variants,
  Model.Interfaces,
  FireDAC.Comp.DataSet;

Type
  TModelQuery = class(TInterfacedObject, iQuery)
    private
      FQuery : TFDQuery;
      FConexao : iConexao;
    public
      constructor Create(aValue : iConexao; aUpdates : Boolean = False);
      destructor Destroy; override;
      class function New(aValue : iConexao; aUpdates : Boolean = False) : iQuery;

      function State : TDataSetState;
      function Query : TObject;
      function Open(aSQL : String = '') : iQuery;
      function Add(aSQL : String) : iQuery;
      function FieldByName(aField : String) : Variant; overload;
      procedure FieldByName(aField : String; aValue: Variant); overload;
      function FieldToString(aField : String) : String;
      procedure Params(aParam: String; aValue: Variant); overload;
      function Params(aParam: String): Variant; overload;
      procedure ExecSQL;
      procedure GetFieldNames(List: TStrings);
      procedure Post;
      function ApplyUpdates(AMaxErrors: Integer = -1): Integer;
      function isEmpty : Boolean;
      function Eof : Boolean;
      procedure First;
      procedure Next;
      function RecNo : Integer;
      procedure Edit;
      procedure MasterSource(aDataSource : TDataSource);
      procedure MasterFields(aFields : String);
      procedure IndexFieldNames(aFields : String);
  end;

implementation

{ TModelQuery }


function TModelQuery.ApplyUpdates(AMaxErrors: Integer = -1): Integer;
var
  oErr: EFDException;
begin
   if FQuery.ApplyUpdates(AMaxErrors) > 0 then
   begin
    FQuery.FilterChanges := [rtModified, rtInserted, rtDeleted, rtHasErrors];
    try
      FQuery.First;
      while not FQuery.Eof do
      begin
        oErr := FQuery.RowError;
        if oErr <> nil then
        begin
          raise exception.Create('ERRO APPLY: ' + oErr.Message);
        end;
        FQuery.Next;
      end;
    finally
      FQuery.FilterChanges := [rtUnmodified, rtModified, rtInserted];
    end;
   end;
end;

constructor TModelQuery.Create(aValue: iConexao; aUpdates : Boolean = False);
begin
  FConexao             := aValue;
  FQuery               := TFDQuery.Create(nil);
  FQuery.Connection    := TFDConnection(FConexao.Connection);
  FQuery.CachedUpdates := aUpdates;
end;

destructor TModelQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

procedure TModelQuery.Edit;
begin
  FQuery.Edit;
end;

function TModelQuery.Eof: Boolean;
begin
  Result := FQuery.Eof;
end;

procedure TModelQuery.ExecSQL;
begin
  try
   FQuery.ExecSQL;
  except
   on E : EFDDBEngineException do
    begin
      case E.Kind of
        ekFKViolated: raise exception.Create(E.Message);
        ekOther: raise exception.Create('ERRO: OUTRO - SQL INCORRETO!');
        ekNoDataFound: raise exception.Create('ERRO: REGISTRO NÃO ENCONTRADO!');
        ekTooManyRows: raise exception.Create('ERRO: MUITAS LINHAS!');
        ekRecordLocked: raise exception.Create('ERRO: REGISTRO BLOQUEADO!');
        ekUKViolated: raise exception.Create('ERRO: CHAVE UNICA VIOLADA!');
        ekObjNotExists: raise exception.Create('ERRO: OBJETO NÃO EXISTE!');
        ekUserPwdInvalid: raise exception.Create('ERRO: USUARIO PWD INVÁLIDO');
        ekUserPwdExpired: raise exception.Create('ERRO: USUARIO PWD EXPIRADO');
        ekUserPwdWillExpire: raise exception.Create('ERRO: USUARIO PWD IRÁ EXPIRAR');
        ekCmdAborted: raise exception.Create('ERRO: CMD ABORTADO');
        ekServerGone: raise exception.Create('ERRO: SERVIDOR FORA DO AR');
        ekServerOutput: raise exception.Create('ERRO: SAÍDA DO SERVIDOR');
        ekArrExecMalfunc: raise exception.Create('ERRO: EXECUÇÃO DE ARRAY MALSUCEDIDA');
        ekInvalidParams: raise exception.Create('ERRO: PARAMETROS INVÁLIDOS');
      else
        raise exception.Create('ERRO DESCONHECIDO: ' + E.message);
      end;
    end;
  end;
end;


procedure TModelQuery.FieldByName(aField: String; aValue: Variant);
begin
  FQuery.FieldByName(aField).Value := aValue;
end;

function TModelQuery.FieldToString(aField: String): String;
begin
  Result := VarToStr(FQuery.FieldByName(aField).Value);
end;

procedure TModelQuery.First;
begin
  FQuery.First;
end;

procedure TModelQuery.GetFieldNames(List: TStrings);
begin
  FQuery.FieldCount;
  FQuery.GetFieldNames(List);
end;

procedure TModelQuery.IndexFieldNames(aFields: String);
begin
  FQuery.IndexFieldNames := aFields;
end;

function TModelQuery.isEmpty: Boolean;
begin
  Result := FQuery.IsEmpty;
end;

procedure TModelQuery.MasterFields(aFields: String);
begin
  FQuery.MasterFields := aFields;
end;

procedure TModelQuery.MasterSource(aDataSource: TDataSource);
begin
  FQuery.MasterSource := aDataSource;
end;

function TModelQuery.FieldByName(aField: String): Variant;
begin
  Result := FQuery.FieldByName(aField).Value;
end;

class function TModelQuery.New(aValue: iConexao; aUpdates : Boolean = False): iQuery;
begin
  Result := Self.Create(aValue, aUpdates);
end;

procedure TModelQuery.Next;
begin
  FQuery.Next;
end;

function TModelQuery.Open(aSQL: String = ''): iQuery;
var
  i : Integer;
  aDecimais : String;
begin
  Result    := Self;
  aDecimais := '0';
  FQuery.Open(aSQL);

  for i := 0 to FQuery.Fields.Count - 1 do
  begin
    if (FQuery.Fields[i] is TNumericField) and not (FQuery.Fields[i] is TIntegerField) then
      (FQuery.Fields[i] as TNumericField).DisplayFormat := '#,###,##0.'+aDecimais.PadLeft((FQuery.Fields[i] as TNumericField).size,'0');
    FQuery.Fields[i].ReadOnly := False;
  end;
end;

function TModelQuery.Params(aParam: String): Variant;
begin
  Result := FQuery.ParamByName(aParam).Value;
end;


procedure TModelQuery.Post;
begin
  FQuery.Post;
end;

procedure TModelQuery.Params(aParam: String; aValue: Variant);
begin
  FQuery.ParamByName(aParam).Value := aValue;
end;

function TModelQuery.Query: TObject;
begin
  Result := FQuery;
end;

function TModelQuery.RecNo: Integer;
begin
  Result := FQuery.RecNo;
end;

function TModelQuery.State: TDataSetState;
begin
  Result := FQuery.State;
end;

function TModelQuery.Add(aSQL: String): iQuery;
begin
  Result := Self;
  FQuery.SQL.Clear;
  FQuery.SQL.Add(aSQL);
end;

end.


unit Model.Interfaces;

interface

uses
  Data.DB, System.Classes, Vcl.ExtCtrls;

type
  iConexao = Interface
    ['{42FDBE52-6C41-43DE-BEF3-26E6711EC683}']
    function Connection : TObject;
    procedure StartTransaction;
    procedure Commit;
    procedure Rollback;
  end;

  iConexaoFactory = interface
    ['{26C12AD8-6DAD-4C00-A5BD-CE358E3CDFC6}']
    function ConexaoERP : iConexao;
  end;

  iQuery = interface
    ['{7B73211E-E8DF-4013-B75F-CA4A2417153C}']
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

  iSessao = interface
    ['{AAB28BC2-A719-4A28-931F-EE45C410A98E}']
    function SetIdUsuario(AIdUsuario : Integer) : iSessao;
    function SetAdmin(aAdmin : Boolean) : iSessao;
    function GetIdUsuario : Integer;
    function GetAdmin : Boolean;
  end;

  iEntidade = interface
    ['{1868AD65-10F8-47A4-9B04-61B7D46CE129}']
    procedure Open(PDataSource : TDataSource; PTabela, PFiltro : String);
    function Save(PDataSource : TDataSource) : Boolean;
    procedure Delete(PTabela, PId : String);
  end;

  iEntidadeFactory = interface
    ['{AE9667A4-505C-4853-A7BE-6D3EDD9E99D2}']
    function Generica : iEntidade;
  end;

implementation


end.

unit Controller.Interfaces;

interface

uses
  Model.EntidadeFactory,
  Model.Interfaces;

type
  iController = interface
    ['{9BF979E0-8254-41E5-9A1B-8B9981F3C931}']
     function Entidades : iEntidadeFactory;
     function Sessao : iSessao;
  end;

implementation

end.

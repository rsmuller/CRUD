program Crud;

uses
  Vcl.Forms,
  View.Main in 'Src\View\View.Main.pas' {VwMain},
  Controller.Conexao in 'Src\Controller\Controller.Conexao.pas',
  Controller.Interfaces in 'Src\Controller\Controller.Interfaces.pas',
  Model.Conexao in 'Src\Model\Conexao\Model.Conexao.pas',
  Model.ConexaoFactory in 'Src\Model\Conexao\Model.ConexaoFactory.pas',
  Model.Query in 'Src\Model\Conexao\Model.Query.pas',
  Model.EntidadeFactory in 'Src\Model\Model.EntidadeFactory.pas',
  Model.EntidadeGenerica in 'Src\Model\Model.EntidadeGenerica.pas',
  Model.Interfaces in 'Src\Model\Model.Interfaces.pas',
  Model.Sessao in 'Src\Model\Model.Sessao.pas',
  ListaDataSet in 'Src\Utils\ListaDataSet.pas',
  View.Padrao in 'Src\View\View.Padrao.pas' {VwPadrao},
  View.Categoria in 'Src\View\View.Categoria.pas' {VwCategoria};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TVwMain, VwMain);
  Application.CreateForm(TVwPadrao, VwPadrao);
  Application.CreateForm(TVwCategoria, VwCategoria);
  Application.Run;
end.

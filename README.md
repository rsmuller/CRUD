# Descrição do Projeto
Este projeto é um exemplo de aplicação CRUD (Create, Read, Update, Delete) desenvolvido em Delphi 10.4 utilizando o banco de dados SQLite. Ele segue os padrões de design MVC (Model-View-Controller) orientados a interfaces, incluindo uma entidade genérica que, ao fornecer o nome da tabela, cria a classe necessária para o CRUD. Além disso, o projeto utiliza o conceito de herança para facilitar a criação de novos cadastros.

# Funcionalidades Principais
CRUD Genérico: Implementação de operações CRUD básicas para qualquer tabela do banco de dados SQLite, utilizando uma entidade genérica.

Padrão MVC: Separação clara entre Model, View e Controller, facilitando a manutenção e expansão do código.

Herança de Cadastros: Utilização do conceito de herança para simplificar a criação de novos cadastros, compartilhando funcionalidades comuns.

Configuração do Ambiente
Delphi 10.4: Certifique-se de ter o Delphi 10.4 instalado no seu ambiente de desenvolvimento.

SQLite: O projeto utiliza o SQLite como banco de dados. Certifique-se de incluir a biblioteca SQLite no seu projeto.

Localização do Banco de Dados:

A base de dados está localizada na pasta /db junto ao projeto.
Certifique-se de ajustar o caminho para apontar para a máquina local ao baixar os fontes.
Estrutura do Projeto
/src: Contém o código-fonte do projeto.

/db: Contém o banco de dados SQLite.

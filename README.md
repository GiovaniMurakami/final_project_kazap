
## PROJETO FINAL - KAZAP

Esse é o projeto de conclusão do Kazap Academy 2023, a proposta é criar um sistema bancário capaz de criar e armazenar clientes, contas, transações, realizar transações entre contas, depósitos e saques, além de mostrar extratos e poder exluir esses itens em ruby.

## Installation

O projeto foi feito utilizando Ruby 3.0.2p107, recomendo utilizar o RBENV para alterar para essa versão.

Para tal:
```bash
    $ rbenv install 3.0.2
    $ rbenv global 3.0.2
```
Foi utilizado sqlite 3 para a criação do banco de dados, abra o terminal do seu sistema Unix e digite:

```bash
    $ sudo apt-get update
    $ sudo apt-get install sqlite3
```

Clone o repositório do projeto:
```bash
  $ git clone #
```

Mude para o diretório do projeto:
```bash
    $ cd #
```

Com o terminal aberto, digite o comando para instalar as dependências do projeto:
```bash
    $ bundle install
```

Crie o banco de dados e rode as migrations:

```bash
    $ sequel -m db/migrations sqlite3://db/bank.db
```

Após isso será possível utilizar as funcionalidades atribuídas no projeto


## Documentação das funcionalidades

### Menu de criação de clientes/contas

#### Criar usuários

#### Criar Contas

#### Excluir contas

### Menu de login em contas

### Diagrama do banco de dados
Pensei em 3 tabelas, uma para os Users, 'address' é um array stringficado, não foi necessário nenhuma chave estrangeira nessa tabela.
A tabela Accounts necessita de uma associação com Users, e Transactions necessita de uma associação com Accounts. 
![Diagrama banco de dados](assets/db_diagram/Screenshot%20from%202023-08-06%2011-44-06.png)

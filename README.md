
## PROJETO FINAL - KAZAP

Esse é o projeto de conclusão do Kazap Academy 2023, a proposta é criar um sistema bancário capaz de criar e armazenar clientes, contas, transações, realizar transações entre contas, depósitos e saques, além de mostrar extratos e poder excluir esses itens em ruby.

## Instalação

O projeto foi feito utilizando Ruby 3.0.2, recomendo utilizar o RBENV para alterar para essa versão.

Para tal, abra o terminal do seu sistema Unix e sigite:
```bash
    $ rbenv install 3.0.2
    $ rbenv global 3.0.2
```
Foi utilizado sqlite 3 para a criação do banco de dados, digite caso não tenha instalado:

```bash
    $ sudo apt-get update
    $ sudo apt-get install sqlite3
```

Clone o repositório do projeto:
```bash
  $ git clone https://github.com/GiovaniMurakami/final_project_kazap
```

Mude para o diretório do projeto:
```bash
    $ cd final_project_kazap
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
É possível acessar esse login digitando '1' no menu inicial da aplicação.
#### Criar usuários
Com essa funcionalidade é possível cadastrar um novo usuário, informando nome, CPF/CNPJ, endereço e número de telefone. Acesse essa funcionalidade digitando '1' no menu de criação de clientes/contas.
#### Criar Contas
Com essa funcionalidade é possível criar uma nova conta e associar a um usuário existente no banco de dados. Acesse essa funcionalidade digitando '2' no menu de criação de clientes/contas.
#### Excluir contas
Com essa funcionalidade é possível excluir uma conta e todas as transações associadas a esse elemento a partir do seu ID. Acesse essa funcionalidade digitando '3' no menu de criação de clientes/contas
### Menu de login em contas
É possível acessar esse login digitando '2' no menu inicial da aplicação.
#### Depósito
Com essa funcionalidade é possível adicionar fundos a uma conta logada, e pagar o limite do cheque-especial automaticamente (se ehouver e se necessário), é possível utilizar essa funcionalidade clicando em '1' após digitar o ID da conta desejada. Após realizado um depósito, é gerado uma transação na tabela 'transactions' com informações dessa movimentação.
#### Saque
Com essa funcionalidade é possível remover fundos de uma conta logada e utilizar o limite disponível do cheque-especial automaticamente (se houver e se necessário), é possível utilizar essa funcionalidade clicando em '2' após digitar o ID da conta desejada. Após realizado um saque, é gerado uma transação na tabela 'transactions' com informações dessa movimentação.
#### Consultar saldo
Com essa funcionalidade é possível verificar o seu saldo atual e também a quantidade de limite disponível no cheque especial, é possível utilizar essa funcionalidade clicando em '3' após digitar o ID da conta desejada
#### Transferẽncias
Com essa funcionalidade é possível transferir fundos para uma conta existente no banco de dados, existem algumas formas de se fazer isso: através de PIX ou TED, caso seja feito por PIX, nenhuma taxa é cobrada, caso TED, uma taxa de 1% sobre o valor da transação é cobrado da conta de origem. Após realizado uma transferência, é gerado uma transação na tabela 'transactions' tanto para quem fez a transferência quanto para quem recebeu com informações da movimentação.

#### Verificar e gerar extrato
Com essa funcionalidade é possível verificar as últimas 10 transações de uma conta logada, após verificar é necessário digitar 's' caso queira um arquivo de extensão JSON com essa informações, esse arquivo é gerado na pasta '/asses/last_transactions/' com um nome único.

## Diagrama do banco de dados
Pensei em 3 tabelas, uma para os Users, 'address' é um array stringficado, não foi necessário nenhuma chave estrangeira nessa tabela.
A tabela Accounts necessita de uma associação com Users, e Transactions necessita de uma associação com Accounts. 
![Diagrama banco de dados](assets/db_diagram/Screenshot%20from%202023-08-06%2011-44-06.png)

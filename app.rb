require 'sequel'

DB = Sequel.sqlite('./db/bank.db')

require './models/users'
require './models/accounts'
require './models/transactions'

puts "Menu de opções"
puts "1. Criar conta ou cliente"
puts "2. Login em conta"
puts "3. Sair"
print "Escolha uma opção: "
option_menu = gets.chomp.to_i

case option_menu
    when 1

        puts "1. Criar cliente"
        puts "2. Criar conta"
        puts "3. Sair"
        print "Escolha uma opção: "
        option_create = gets.chomp.to_i

        case option_create

        when 1
            print "Informe o seu nome: "
            name = gets.chomp

            print "Informe o seu CPF ou CNPJ: "
            cpf_cnpj = gets.chomp

            print "Informe a sua rua: "
            street = gets.chomp

            print "Informe o número do local: "
            house_number = gets.chomp

            print "Informe o bairro: "
            neighborhood = gets.chomp

            print "Informe o estado: "
            state = gets.chomp

            address = [street, cpf_cnpj, house_number, neighborhood, state]

            print "Informe um telefone de contato: "
            phone_number = gets.chomp

            user = User.new(
                name: name,
                cpf_cnpj: cpf_cnpj,
                address: "#{address}",
                phone_number: phone_number
            )

            user.save if user.valid?

        when 2

            print "Informe o ID do cliente: "
            user_id = gets.chomp.to_i
            user = User.where(id: user_id).first
            new_account = Account.new()
            user.add_account(new_account)

        when 3
            puts "Até mais"
            return
        else
            puts "Opção inválida"
        end
    when 2
        print "Informe o ID da sua conta: "
        account_id = gets.chomp.to_i
        account = Account.where(id: account_id).first

            loop do

                overdraft = account.overdraft
                balance = account.balance

                puts "Menu de opções"
                puts "1. Realizar depósito"
                puts "2. Realizar saque"
                puts "3. Consultar saldo"
                puts "4. Transferências"
                puts "5. Extrato das últimas 10 transações"
                puts '============================='
                print "Escolha uma opção: "


                option = gets.chomp.to_i
                
                case option
                    when 1

                        puts "Foi escolhido: Depósito"
                        print "Informe o valor do depósito: "
                        deposit = gets.chomp.to_f

                        new_transaction = Transaction.new(
                            amount: deposit,
                            description: "deposit"
                        )

                        account.add_transaction(new_transaction)

                        if  account.overdraft > 0
                            puts "Você possui pendências com o cheque especial no total de #{account.overdraft}"
                            
                            if deposit < account.overdraft
                                puts "Com esse deposito, o valor final de pendências do cheque especial será: #{account.overdraft - deposit}"
                                account.overdraft -= deposit
                            else
                                puts "Com esse depóstito, o valor final das pendências do cheque especial será 0"
                                account.balance += deposit - account.overdraft
                                account.overdraft = 0
                            end
                        else
                            account.balance += deposit
                        end

                        account.save

                    when 2

                        puts "Foi escolhido saque"
                        print "Informe o valor do saque: "
                        withdraw = gets.chomp.to_f

                        new_transaction = Transaction.new(
                            amount: withdraw,
                            description: "withdraw"
                        )

                        account.add_transaction(new_transaction)      

                        overdraft = 100 - account.overdraft
                        if withdraw > account.balance + overdraft
                            puts "Saldo insuficiente"
                        else
                            if withdraw > account.balance
                                account.overdraft += withdraw - account.balance
                                account.balance = 0
                            else
                                account.balance -= withdraw
                            end
                        end

                        account.save

                    when 3
                        puts "Foi escolhido: Consultar saldo"
                        puts "O seu saldo é de #{account.balance}, com cheque especial de : #{100 - account.overdraft}"
                    when 4
                        puts "Escolheu opção 4"
                    when 5

                        last_transactions = Transaction.where(account_id: account_id).order(Sequel.desc(:created_at)).limit(10)

                        last_transactions.each do |transaction|
                        puts "ID da transação: #{transaction.id}"
                        puts "ID da conta: #{transaction.account_id}"
                        puts "Valor: #{transaction.amount}"
                        puts "Descrição: #{transaction.description}"
                        puts "Criado em: #{transaction.created_at}"
                        puts "-----------------------------"
                        end

                    else
                        puts "Escolheu opção inválida"
                end
            end
    when 3
        puts "Até mais"
    else
        puts "Escolheu opção inválida" 
end
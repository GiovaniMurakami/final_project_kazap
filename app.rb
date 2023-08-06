require 'sequel'
require 'json'
require 'uuid'
require 'rainbow'


DB = Sequel.sqlite('./db/bank.db')

require './models/users'
require './models/accounts'
require './models/transactions'

require_relative 'modules/create_users_utils'
require_relative 'modules/create_accounts_utils'
require_relative 'modules/deposit_utils'
require_relative 'modules/bank_statements_utils'

loop do
    puts "=================================="
    puts "Menu de opções"
    puts "=================================="
    puts "1. Criar/exluir conta ou criar cliente"
    puts "2. Login em conta"
    puts "3. Sair"
    print "Escolha uma opção: "
    option_menu = gets.chomp.to_i

    case option_menu
        when 1
            loop do
            puts "=================================="
            puts "1. Criar cliente"
            puts "2. Criar conta"
            puts "3. Excluir conta"
            puts "4. Sair"
            puts "=================================="
            print "Escolha uma opção: "
            option_create = gets.chomp.to_i

                case option_create
                    when 1
                        Create_user_utils.create_new_user
                    when 2
                        print "Informe o ID do cliente: "
                        user_id = gets.chomp.to_i
                        Create_accounts_utils.create_new_account(user_id)
                    when 3
                        print "Informe o ID da conta a ser excluída: "
                        account_id = gets.chomp.to_i
                        account = Account[id: account_id]

                        if account
                            transactions_to_delete = Transaction.where(account_id: account_id)
                            transactions_to_delete.each(&:delete)
                            account.delete
                            puts Rainbow("Conta e transações associadas excluídas com sucesso!").green
                        else
                            puts Rainbow("Conta não encontrada.").red
                        end
                    when 4
                        puts "Até mais"
                        break
                    else
                        puts Rainbow("Opção inválida").red
                    end
                end
        when 2
            print "Informe o ID da sua conta: "
            account_id = gets.chomp.to_i
            account = Account.where(id: account_id).first
                if account
                loop do
                    overdraft = account.overdraft
                    balance = account.balance

                    puts "Menu de opções"
                    puts "1. Realizar depósito"
                    puts "2. Realizar saque"
                    puts "3. Consultar saldo"
                    puts "4. Transferências"
                    puts "5. Extrato das últimas 10 transações"
                    puts "6. Sair"
                    puts '============================='
                    print "Escolha uma opção: "


                    option = gets.chomp.to_i
                    
                    case option
                        when 1
                            puts "Foi escolhido: Depósito"
                            print "Informe o valor do depósito: "  
                            deposit = gets.chomp.to_f

                            Deposit_utils.new_deposit(account, deposit, "deposit")
                            Bank_statements.show_balance(account)
                        when 2
                            puts "Foi escolhido saque"
                            print "Informe o valor do saque: "
                            withdraw = gets.chomp.to_f

                            Deposit_utils.new_withdraw(account, withdraw, "withdraw")
                            Bank_statements.show_balance(account)
                        when 3
                            puts "Foi escolhido: Consultar saldo"
                            Bank_statements.show_balance(account)
                        when 4
                            puts "Foi escolhido: Tranferência"
                            puts "1. TED"
                            puts "2. PIX"
                            puts "3. Voltar"
                            print "Escolha uma opção: "
                            option_transaction = gets.chomp.to_i

                            case option_transaction
                            when 1
                                puts "Transações do tipo TED possuem uma taxa de 1%"
                                print "Informe o valor da transferência: "
                                transaction_amount = gets.chomp.to_f
                                print "Informe o ID da conta destino: "
                                account_id = gets.chomp.to_i
                                account_to = Account[id: account_id]

                                Deposit_utils.transaction_out(account, transaction_amount, transaction_amount * 0.01, "TED_out", account_to)
                                Bank_statements.show_balance(account)
                            when 2
                                print "Informe o valor da transferência: "
                                transaction_amount = gets.chomp.to_f
                                print "Informe o ID da conta destino: "
                                account_id = gets.chomp.to_i
                                account_to = Account[id: account_id]

                                Deposit_utils.transaction_out(account, transaction_amount, 0, "PIX_out", account_to)

                            when 3
                                "Até mais"
                                break
                            else
                                puts Rainbow("Opção inválida").red
                            end

                        when 5
                            Bank_statements.show_last_statements(account.id)
                            print "Exportar extrato?[s/n] "
                            choose = gets.chomp.downcase
                            if choose == 's'
                                Bank_statements.export_statements(account.id)
                            else
                                break
                            end
                        when 6
                            puts Rainbow("Até mais").green
                            break
                        else
                            puts Rainbow("Opção inválida").red
                    end
                end
            else
                puts Rainbow("Conta inexistente").red
            end
        when 3
            puts Rainbow("Até mais").green
            break
        else
            puts Rainbow("Opção inválida").red 
    end
end

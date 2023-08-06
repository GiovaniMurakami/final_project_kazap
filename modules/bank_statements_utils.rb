module Bank_statements
    def self.show_last_statements(account_id)
        last_transactions = Transaction.where(account_id: account_id).order(Sequel.desc(:created_at)).limit(10)

        export = last_transactions.each do |transaction|
            puts "ID da transação: #{transaction.id}"
            puts "ID da conta: #{transaction.account_id}"
            puts "Valor: #{transaction.amount}"
            puts "Descrição: #{transaction.description}"
            puts "Criado em: #{transaction.created_at}"
            puts "------------------------------------"
        end
    end

    def self.show_balance(account)
        puts "O seu saldo é de #{account.balance}, com limite disponível no cheque especial de : #{100 - account.overdraft}"
        puts "============================="
    end

    def self.export_statements(account_id)
        last_10_transactions = Transaction.where(account_id: account_id).order(Sequel.desc(:created_at)).limit(10)
        transactions_array = []

        last_10_transactions.each do |transaction|
        transactions_array << {
            transaction_id: transaction.id,
            account_id: transaction.account_id,
            amount: transaction.amount,
            description: transaction.description,
            created_at: transaction.created_at
        }
        end

        uuid = UUID.new.generate
        file_name = "last_10_transaction.json"

        File.open(file_name, 'w') do |file|
        file.puts JSON.pretty_generate(transactions_array)
        end
    end
end
module Deposit_utils
    def self.new_deposit(account, deposit, description)

        if account.overdraft > 0
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

        new_transaction(account, deposit, "deposit")

    end

    def self.new_withdraw(account, withdraw)

        
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
        
        new_transaction(account, withdraw, "withdraw")

    end
    
    def self.new_transaction(account, amount, description)
        
        new_transaction = Transaction.new(
            amount: amount,
            description: description
        )

        account.add_transaction(new_transaction)      
        account.save

    end
end
module Deposit_utils
    def self.new_deposit(account, deposit, description)
        new_amount = pay_overdraft(account, deposit)
        account.balance += new_amount
        account.save
        new_transaction(account, deposit, description)
    end

    def self.new_withdraw(account, withdraw, description)
        if payable?(account, withdraw)
            if withdraw > account.balance
                update_overdraft = withdraw - account.balance
                account.overdraft = update_overdraft
                account.balance = 0
                account.save
            else
                account.balance -= withdraw
            end
        else
            puts "Saldo insuficiente"
        end
        new_transaction(account, withdraw, description)
    end

    def self.transaction_out(account, amount, billing, description, account_to)
        if payable?(account, amount + billing)
            description_to = "PIX_in" if description  == "PIX_out"
            description_to = "TED_in" if description  == "TED_out"
            new_withdraw(account, amount + billing, description)
            transaction_in(account_to, amount, description_to)
        else
            puts "Saldo insuficiente"
        end
    end

    def self.transaction_in(account, amount, description)
        new_amount = pay_overdraft(account, amount)
        account.balance += new_amount
        account.save
        new_transaction(account, amount, description)
    end

    
    def self.pay_overdraft(account, amount)
        if account.overdraft > 0
            new_amount = amount - account.overdraft
            if new_amount >= 0
                account.overdraft = 0
                return new_amount
            else
                account.overdraft -= amount
                return 0
            end
        else
            return amount
        end
    end

    def self.new_transaction(account, amount, description)
        new_transaction = Transaction.new(
            amount: amount,
            description: description
        )
        account.add_transaction(new_transaction)      
        account.save
    end
    
    def self.payable?(account, amount)
        return account.balance + (100 - account.overdraft) >= amount
    end
end
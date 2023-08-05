module Create_accounts_utils

    def self.create_new_account(user_id)
        user = User.where(id: user_id).first
        new_account = Account.new()
        user.add_account(new_account)
        puts "Conta cadastrada com sucesso, o seu ID é: #{new_account.id}"
    end
    
end
module Create_user_utils
    def self.create_new_user
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
        puts Rainbow("Usuário cadastrado com sucesso, o seu ID é: #{user.id}").green
    end
end
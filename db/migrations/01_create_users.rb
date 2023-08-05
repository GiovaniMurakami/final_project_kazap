Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name, null: false
      String :cpf_cnpj, null: false, unique: true
      String :address, text: true, default: '[]'
      String :phone_number, null: false
    end
  end
end

Sequel.migration do
  change do
    create_table(:users) do
      primary_key :id
      String :name, null: false
      String :cpf_cnpj, null: false, unique: true
      foreign_key :address_id, :address, null: false
      String :phone_number, null: false
    end
  end
end

Sequel.migration do
  change do
    create_table(:addresses) do
      primary_key :id
      String :street, null:false
      String :house_number, null:false, size: 5
      String :city, null: false
      String :postal_code, null: false
      String :country, nulll: false
    end
  end
end

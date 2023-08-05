Sequel.migration do
  change do
    create_table(:accounts) do
      primary_key :id
      foreign_key :user_id, :users, null: false
      Float :balance, default: 0.0
      Float :overdraft, default: 0.0
    end
  end
end

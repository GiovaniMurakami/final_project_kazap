Sequel.migration do
  change do
    create_table(:transactions) do
      primary_key :id
      foreign_key :account_id, :accounts, null: false
      Float :amount, null: false
      String :description, null: false
      DateTime :created_at, null: false, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end

class Account < Sequel::Model
    many_to_one :users
    one_to_many :transactions
end

class Transaction < Sequel::Model
  many_to_one :account

  def validate
    super
    
  end
end

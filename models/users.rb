class User < Sequel::Model
  one_to_many :accounts
  plugin :validation_helpers

  def validate
    super
    
  end
end

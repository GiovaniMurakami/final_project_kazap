class User < Sequel::Model
  one_to_many :accounts
  plugin :validation_helpers

  def validate
    validates_presence [:name, :cpf_cnpj, :address, :phone_number]
    validates_unique [:cpf_cnpj]
  end
end

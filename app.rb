require 'sequel'

DB = Sequel.sqlite('./db/bank.db')

require './models/users'
require './models/accounts'
require './models/transactions'
require('rspec')
require('pg')
require('train')
require('city')
require('pry')
require('ticket')

DB = PG.connect({:dbname => 'train_sys_test'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM cities *;")
    DB.exec("DELETE FROM trains *;")
    DB.exec("DELETE FROM stops *;")
    DB.exec("DELETE FROM tickets *;")
  end
end

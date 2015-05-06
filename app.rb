require("sinatra")
require("sinatra/reloader")
require("./lib/train")
require("./lib/city")
also_reload("lib/**/*.rb")
require("pg")

DB = PG.connect({:dbname => "train_sys"})


get('/') do
  erb(:index)
end

get('/operator') do
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

get('/trains') do
  @trains = Train.all()
  erb(:trains)
end

get('cities') do
  @cities = City.all()
  erb(:cities)
end

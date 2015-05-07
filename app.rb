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

post('/trains') do
  t_name = params.fetch("t_name")
  train = Train.new({t_name: t_name, id: nil}).save()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

post('/cities') do
  c_name = params.fetch("c_name")
  city = City.new({c_name: c_name, id: nil}).save()
  @cities = City.all()
  @trains = Train.all()
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

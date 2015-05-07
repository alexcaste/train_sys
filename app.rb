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

get('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i())
  @cities = City.all()
  erb(:train_info)
end


patch('/train/:id') do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  city_id = params.fetch("city_id").to_i()
  time = params.fetch("time").to_i()
  if time != (0)
    @train.update({city_ids: [city_id]})
    @train.add_time({time: time, city_id: city_id})
  end
  @cities = City.all()
  erb(:train_info)
end

patch('/train_edit/:id') do
  train_id = params.fetch("id").to_i()
  @train = Train.find(train_id)
  t_name = params.fetch("t_name")
  @train.update({t_name: t_name, id: train_id})
  @cities = City.all()
  erb(:train_info)
end


delete('/trains/:id') do
  @train = Train.find(params.fetch("id").to_i)
  @train.delete()
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

get('/cities/:id') do
  @city = City.find(params.fetch("id").to_i())
  @trains = Train.all()
  erb(:city_info)
end

delete('/cities/:id') do
  @city = City.find(params.fetch("id").to_i)
  @city.delete()
  @trains = Train.all()
  @cities = City.all()
  erb(:operator)
end

patch('/city/:id') do
  train_id = params.fetch("train_id").to_i()
  @train = Train.find(train_id)
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  time = params.fetch("time").to_i()
  if time != (0)
    @train.update({city_ids: [city_id]})
    @train.add_time({time: time, city_id: city_id})
  end
  @trains = Train.all()
  erb(:city_info)
end

patch('/city_edit/:id') do
  city_id = params.fetch("id").to_i()
  @city = City.find(city_id)
  c_name = params.fetch("c_name")
  @city.update({c_name: c_name, id: city_id})
  @trains = Train.all()
  erb(:city_info)
end

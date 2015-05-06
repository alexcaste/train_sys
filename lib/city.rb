class City

attr_reader(:c_name, :id)

  define_method(:initialize) do |attributes|
    @c_name = attributes.fetch(:c_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_cities = DB.exec("SELECT * FROM cities;")
    cities = []
    returned_cities.each() do |city|
      c_name = city.fetch("c_name")
      id = city.fetch("id").to_i()
      cities.push(City.new({c_name: c_name, id: id}))
    end
    cities
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM cities WHERE id = #{@id};")
    @c_name = result.first().fetch("c_name")
    City.new({c_name: @c_name, id: @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO cities (c_name) VALUES ('#{@c_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |dup_eq|
    self.c_name().==(dup_eq.c_name()).&(self.id().==(dup_eq.id()))
  end

  define_method(:update) do |attributes|
    @c_name = attributes.fetch(:c_name, @c_name)
    @id = self.id()
    DB.exec("UPDATE cities SET c_name ='#{@c_name}' WHERE id = #{@id};")

    attributes.fetch(:train_ids, []).each() do |train_id|
      DB.exec("INSERT INTO stops (train_ids, city_ids) VALUES (#{train_id}, #{self.id()});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM cities WHERE id =#{self.id()};")
  end

  define_method(:trains) do
    city_trains = []
    results = DB.exec("SELECT train_ids FROM stops WHERE city_ids = #{self.id()};")
    results.each() do |result|
      train_id = result.fetch("train_ids").to_i()
      train = DB.exec("SELECT * FROM trains WHERE id = #{train_id};")
      t_name = train.first().fetch("t_name")
      city_trains.push(Train.new({t_name: t_name, id: train_id}))
    end
    city_trains
  end
end

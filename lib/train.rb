class Train

attr_reader(:t_name, :id)

  define_method(:initialize) do |attributes|
    @t_name = attributes.fetch(:t_name)
    @id = attributes.fetch(:id)
  end

  define_singleton_method(:all) do
    returned_trains = DB.exec("SELECT * FROM trains;")
    trains = []
    returned_trains.each() do |train|
      t_name = train.fetch("t_name")
      id = train.fetch("id").to_i()
      trains.push(Train.new({t_name: t_name, id: id}))
    end
    trains
  end

  define_singleton_method(:find) do |id|
    @id = id
    result = DB.exec("SELECT * FROM trains WHERE id = #{@id};")
    @t_name = result.first().fetch("t_name")
    Train.new({t_name: @t_name, id: @id})
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO trains (t_name) VALUES ('#{@t_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  define_method(:==) do |dup_eq|
    self.t_name().==(dup_eq.t_name()).&(self.id().==(dup_eq.id()))
  end

  define_method(:update) do |attributes|
    @t_name = attributes.fetch(:t_name, @t_name)
    @id = self.id()
    DB.exec("UPDATE trains SET t_name ='#{@t_name}' WHERE id = #{@id};")

    attributes.fetch(:city_ids, []).each() do |city_id|
      DB.exec("INSERT INTO stops (train_ids, city_ids) VALUES (#{self.id()}, #{city_id});")
    end
  end

  define_method(:delete) do
    DB.exec("DELETE FROM trains WHERE id =#{self.id()};")
  end

  define_method(:cities) do
    city_trains = []
    results = DB.exec("SELECT city_ids FROM stops WHERE train_ids = #{self.id()};")
    results.each() do |result|
      city_id = result.fetch("city_ids").to_i()
      city = DB.exec("SELECT * FROM cities WHERE id = #{city_id};")
      c_name = city.first().fetch("c_name")
      city_trains.push(City.new({c_name: c_name, id: city_id}))
    end
    city_trains
  end

  define_method(:time) do |city_id|
    results = DB.exec("SELECT time FROM stops WHERE train_ids = #{self.id()}} AND city_ids = #{city_id};")
    stop_time = results.first().fetch("time").to_i()
    stop_time
  end

  define_method(:add_time) do |time, city_id|
    id = self.id()
    DB.exec("UPDATE stops SET time =#{time} WHERE train_ids = #{id}} AND city_ids = #{city_id};")
  end
end

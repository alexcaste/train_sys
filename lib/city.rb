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

end

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
end

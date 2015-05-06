require('spec_helper')

describe(City) do

  describe('#c_name') do
    it("returns the name of the city") do
      new_city = City.new(c_name: "Portland", id: nil)
      expect(new_city.c_name()).to(eq("Portland"))
    end
  end

  describe("#id") do
    it("returns the id") do
      city = City.new({c_name: "Portland", id: 1})
      expect(city.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no cities") do
      expect(City.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a city by its ID number") do
      test_city = City.new({c_name: "New York", id: nil})
      test_city.save()
      test_city2 = City.new({c_name: "Portland", id: nil})
      test_city.save()
      expect(City.find(test_city.id())).to(eq(test_city))
    end
  end

  describe('#==') do
    it("is the same if the city name and id is the same") do
      city = City.new({c_name: "Baltimore", id: nil})
      city2 = City.new({c_name: "Baltimore", id: nil})
      expect(city).to(eq(city2))
    end
  end

  dsecribe("#update") do
    it("lets you update cities in the database") do
      city = City.new({c_name: "Baltimore", id: nil})
      city.save()
      city.update({c_name: "Portland"})
      expect(city.c_name()).to(eq("Portland"))
    end
  end
end

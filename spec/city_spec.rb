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
      city = City.new(c_name: "Portland", id: 1)
      expect(city.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no cities") do
      expect(City.all()).to(eq([]))
    end
  end
end

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

  describe("#update") do
    it("lets you update cities in the database") do
      city = City.new({c_name: "Baltimore", id: nil})
      city.save()
      city.update({c_name: "Portland"})
      expect(city.c_name()).to(eq("Portland"))
    end

    it("lets you add a train to a city") do
      city = City.new({c_name: "Baltimore", id: nil})
      city.save()
      concrete = Train.new({t_name: "Concrete", id: nil})
      concrete.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      city.update({train_ids: [concrete.id(), rock.id()]})
      expect(city.trains()).to(eq([concrete, rock]))
    end
  end

  describe('#trains') do
    it("returns all of the trains in a city") do
      city = City.new({c_name: "Baltimore", id: nil})
      city.save()
      concrete = Train.new({t_name: "Concrete", id: nil})
      concrete.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      city.update({train_ids: [concrete.id(), rock.id()]})
      expect(city.trains()).to(eq([concrete, rock]))
    end
  end

  describe("#delete") do
    it("lets you delete a city from the database") do
      city = City.new({c_name: "Baltimore", id: nil})
      city.save()
      city2 = City.new({c_name: "Portland", id: nil})
      city2.save()
      city.delete()
      expect(City.all()).to(eq([city2]))
    end
  end
end

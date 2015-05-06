require('spec_helper')

describe(Train) do

  describe('#t_name') do
    it("returns the name of the train") do
      new_train = Train.new(t_name: "Concrete", id: nil)
      expect(new_train.t_name()).to(eq("Concrete"))
    end
  end

  describe("#id") do
    it("returns the id") do
      train = Train.new({t_name: "Concrete", id: 1})
      expect(train.id()).to(eq(1))
    end
  end

  describe(".all") do
    it("starts off with no trains") do
      expect(Train.all()).to(eq([]))
    end
  end

  describe(".find") do
    it("returns a train by its ID number") do
      test_train = Train.new({t_name: "A-Line", id: nil})
      test_train.save()
      test_train2 = Train.new({t_name: "Concrete", id: nil})
      test_train.save()
      expect(Train.find(test_train.id())).to(eq(test_train))
    end
  end

  describe('#==') do
    it("is the same if the train name and id is the same") do
      train = Train.new({t_name: "A-Line", id: nil})
      train2 = Train.new({t_name: "A-Line", id: nil})
      expect(train).to(eq(train2))
    end
  end

  describe("#update") do
    it("lets you update trains in the database") do
      train = Train.new({t_name: "A-Line", id: nil})
      train.save()
      train.update({t_name: "Concrete"})
      expect(train.t_name()).to(eq("Concrete"))
    end


    it("lets you add a train to a train") do
      baltimore = City.new({c_name: "Baltimore", id: nil})
      baltimore.save()
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id(), baltimore.id()]})
      expect(rock.cities()).to(eq([portland, baltimore]))
    end
  end

  describe('#cities') do
    it("returns all of the cities for a train") do
      baltimore = City.new({c_name: "Baltimore", id: nil})
      baltimore.save()
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id(), baltimore.id()]})
      expect(rock.cities()).to(eq([portland, baltimore]))
    end
  end

  describe("#delete") do
    it("lets you delete a train from the database") do
      train = Train.new({t_name: "A-Line", id: nil})
      train.save()
      train2 = Train.new({t_name: "Concrete", id: nil})
      train2.save()
      train.delete()
      expect(Train.all()).to(eq([train2]))
    end
  end

  describe('#time') do
    it("returns the time of a specific train") do
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id()]})
      rock.add_time({time: 1200, city_id: portland.id()})
      expect(rock.time(portland.id())).to(eq(1200))
    end
  end

  describe('#add_time') do
    it("allows you to add a time to a specific train") do
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id()]})
      rock.add_time({time: 1200, city_id: portland.id()})
      expect(rock.time(portland.id())).to(eq(1200))
    end
  end

  describe('#time_table') do
    it("returns cities and times associated with a train") do
      baltimore = City.new({c_name: "Baltimore", id: nil})
      baltimore.save()
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id(), baltimore.id()]})
      rock.add_time({time: 1200, city_id: portland.id()})
      rock.add_time({time: 1000, city_id: baltimore.id()})
      expect(rock.time_table()).to(eq(["Portland", 1200, "Baltimore", 1000]))      
    end
  end
end

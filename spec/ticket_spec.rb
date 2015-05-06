require('spec_helper')

describe(Ticket) do

  describe('#stops') do
    it("returns the cities associated with the ticket") do
      baltimore = City.new({c_name: "Baltimore", id: nil})
      baltimore.save()
      portland = City.new({c_name: "Portland", id: nil})
      portland.save()
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      rock.update({city_ids: [portland.id(), baltimore.id()]})
      joker = Ticket.new(train_id: rock.id(), id: nil)
      joker.save()
      expect(joker.stops()).to(eq([portland, baltimore]))
    end
  end
end

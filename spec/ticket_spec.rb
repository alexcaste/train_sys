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

  describe('#tik_name') do
    it('returns the name associated with the ticket') do
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      ticket = Ticket.new(train_id: rock.id(), id: nil)
      ticket.save()
      expect(ticket.tik_name()).to(eq("Rocks"))
    end
  end

  describe(".all") do
    it("starts off with no cities") do
      expect(City.all()).to(eq([]))
    end

    it("shows saved tickets") do
      rock = Train.new({t_name: "Rocks", id: nil})
      rock.save()
      ticket = Ticket.new(train_id: rock.id(), id: nil)
      ticket.save()
    expect(Ticket.all()).to(eq([ticket]))
    end
  end
end

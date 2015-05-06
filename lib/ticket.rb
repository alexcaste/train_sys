class Ticket

  attr_reader(:train_id, :id)

  define_method(:initialize) do |attributes|
    @train_id = attributes.fetch(:train_id)
    @id = attributes.fetch(:id).to_i()
  end


  define_singleton_method(:all) do
    returned_ticket = DB.exec("SELECT * FROM tickets;")
    tickets = []
    returned_ticket.each() do |ticket_obj|
      train_id = ticket_obj.fetch("train_id")
      id = ticket_obj.fetch("id").to_i()
      tickets.push(Ticket.new({:train_id => train_id, :id =>id}))
    end
    tickets
  end

  define_method(:save) do
    result = DB.exec("INSERT INTO tickets (train_id) VALUES ('#{@train_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  define_method(:==) do |dup_ticket|
    self.train_id().==(dup_ticket.train_id()).&(self.id().==(dup_ticket.id()))
  end

  define_singleton_method(:find) do |ticket_id|
    search_ticket = nil
    Ticket.all().each() do |ticket_obj|
      if ticket_obj.id() == ticket_id
        search_ticket = ticket_obj
      end
    end
    search_ticket
  end

  define_method(:stops) do
    result = DB.exec("SELECT * FROM trains WHERE id = #{@train_id};")
    t_name = result.first().fetch("t_name")
    id = result.first().fetch("id").to_i()
    train = Train.new(t_name: t_name, id: id)
    train.cities()
  end

end

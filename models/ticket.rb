require_relative('../db/sql_runner')

class Ticket

  attr_reader :id
  attr_accessor :customer_id, :film_id


  def initialize(ticket_details)
    @id = ticket_details['id'].to_i if ticket_details['id']
    @customer_id = ticket_details['customer_id'].to_i
    @film_id = ticket_details['film_id'].to_i
    @price = ticket_details['price'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM tickets"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM tickets"
    tickets = SqlRunner.run(sql)
    results = tickets.map{Ticket.new(tickets)}
    return results
  end

  def save
    sql = "INSERT INTO tickets (customer_id,film_id,price) VALUES ($1,$2,$3) RETURNING id"
    values = [@customer_id,@film_id,@price]
    ticket = SqlRunner.run(sql,values)[0]
    @id = ticket['id'].to_i
  end

  def delete
    sql = "DELETE FROM tickets WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

end

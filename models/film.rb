require_relative('../db/sql_runner')


class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(film_details)
    @id = film_details['id'].to_i if film_details['id']
    @title = film_details['title']
    @price = film_details['price'].to_i
  end


  def self.delete_all()
    sql = "DELETE FROM films"
    SqlRunner.run(sql)
  end

  def self.all
    sql ="SELECT * FROM films"
    films = SqlRunner.run(sql)
    results = films.map{|film| Film.new(film)}
    return results
  end

  def save
    sql = "INSERT INTO films (title,price) VALUES ($1,$2) RETURNING id"
    values = [@title,@price]
    film = SqlRunner.run(sql,values)[0]
    @id = film['id'].to_i
  end

  def delete
    sql = "DELETE FROM films WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update
    sql = "UPDATE films SET (title,price) = ($1,$2) where id = $3"
    values = [@title,@price,@id]
  end

  def customers
    sql = "SELECT customers.* FROM customers
    INNER JOIN tickets
    ON tickets.customers_id = customer.id
    WHERE film_id = $1"
    values = [@id]
    customers = SqlRunner.run(sql,values)
    return customers.map{|customer| Customer.new(customer)}
  end
end

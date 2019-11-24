require_relative('../db/sql_runner')


class Customer

attr_accessor :id
attr_reader :name, :cash


  def initialize(customer_details)
    @id = customer_details['id'].to_i if customer_details['id']
    @name = customer_details['name']
    @cash = customer_details['cash'].to_i
  end

  def self.delete_all
    sql = "DELETE FROM customers"
    SqlRunner.run(sql)
  end

  def self.all
    sql = "SELECT * FROM customers"
    customers = SqlRunner.run(sql)
    results = customers.map{|customer| Customer.new(customer)}
    return results
  end

  def save
    sql = "INSERT INTO customers (name,cash) VALUES ($1,$2) RETURNING id"
    values = [@name,@cash]
    customer = SqlRunner.run(sql,values)[0]
    @id = customer['id'].to_i
  end

  def delete
    sql = "DELETE FROM customers WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)
  end

  def update
    sql = "UPDATE customers SET (name,cash) = ($1,$2) where id = $3"
    values = [@name,@cash,@id]
    SqlRunner.run(sql,values)
  end

  def films
    sql = "SELECT film.* FROM films
    INNER JOIN tickets
    ON film_id = film.id
    WHERE film_id = $1"
    values = [@id]
    films = SqlRunner.run(sql,values)
    return films.map{|film| Film.new(film)}
  end
end

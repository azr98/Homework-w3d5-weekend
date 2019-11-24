require_relative('models/customer')
require_relative('models/film')
require_relative('models/ticket')

require('pry-byebug')

Customer.delete_all
Film.delete_all
Ticket.delete_all


customer1 = Customer.new({
  'name' => 'Azhar',
  'cash' => 1000000
  })

customer1.save

customer2 = Customer.new({
  'name' => 'Esa',
  'cash' => 20
  })

customer2.save

film1 = Film.new({
  'title' => 'Blade Runner',
  'price' => 20
  })

film1.save

ticket1 = Ticket.new({
  'customer_id' => customer1.id,
  'film_id' => film1.id,
  'price' => film1.price
  })

ticket1.save


binding.pry
nil

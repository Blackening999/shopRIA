
User.create([
  { :login_name => 'admin',
    :first_name => 'admin', 
    :last_name  => 'admin', 
    :password   => 'aA1!', 
    :password_confirmation => 'aA1!', 
    :email      => 'admin@gmail.com', 
    :region     => 'South', 
    :role       => 'Administrator' },
  { :login_name => 'customer',
    :first_name => 'customer', 
    :last_name  => 'customer', 
    :password   => 'aA1!', 
    :password_confirmation => 'aA1!', 
    :email      => 'customer@gmail.com', 
    :region     => 'South', 
    :role       => 'Customer' },
  { :login_name => 'merchandiser',
    :first_name => 'Homer', 
    :last_name  => 'Simpson', 
    :password   => 'aA1!', 
    :password_confirmation => 'aA1!', 
    :email      => 'merchandiser@gmail.com', 
    :region     => 'South', 
    :role       => 'Merchandiser'},
  { :login_name => 'merchandiser2',
    :first_name => 'John', 
    :last_name  => 'Smith', 
    :password   => 'aA1!', 
    :password_confirmation => 'aA1!', 
    :email      => 'merchandiser2@gmail.com', 
    :region     => 'South', 
    :role       => 'Merchandiser'},  
  { :login_name => 'supervisor',
    :first_name => 'supervisor', 
    :last_name  => 'supervisor', 
    :password   => 'aA1!', 
    :password_confirmation => 'aA1!', 
    :email      => 'supervisor@gmail.com', 
    :region     => 'South', 
    :role       => 'Supervisor' }
  ])

items = Item.create([{ item_name: "Orange1", item_description: "Orange1", price: 10 },
                     {item_name: "Onion1", item_description: "Onion1", price: 2 }])


order1=Order.create(order_number: '000001', 
           total_price: 10,
           total_num_of_items: 5,
           max_discount: 0,
           status: "Ordered",         
           role: "merchandiser",
           date_of_ordering: Time.now, 
             delivery_date: Time.now,
             pref_delivery_date: Time.now,  
             credit_card_type: "MasterCard")

order_item1 = OrderItem.create(price_per_line: 50, dimension: "Box", quantity: 1, item_id: items[0].id)
order_item2 = OrderItem.create(price_per_line: 40, dimension: "Package", quantity: 2, item_id: items[1].id)

order1.order_items<<order_item1
order1.order_items<<order_item2

order2=Order.create(order_number: '000002', 
           total_price: 10,
           total_num_of_items: 5,
           max_discount: 0,
           status: "Ordered",         
           role: "merchandiser2",
           date_of_ordering: Date.parse('2012-02-03'), 
             delivery_date: Date.parse('2012-03-03'),
             pref_delivery_date: Time.now,  
             credit_card_type: "American Express")

order_item21 = OrderItem.create(price_per_line: 100, dimension: "Box", quantity: 2, item_id: items[0].id)

order2.order_items<<order_item21

user = User.where(role:"Customer").first

user.orders<<order1
user.orders<<order2


# encoding: utf-8
# Autogenerated by the db:seed:dump task
# Do not hesitate to tweak this to your needs
# blackening !Q1q    admin
# customer  1q!Q customer

Item.create([
  { :item_name => "Orange1", :item_description => "Orange1", :price => 10.0, :dimension => "Box", :created_at => "2013-02-08 11:52:35", :updated_at => "2013-02-08 11:52:35" },
  { :item_name => "Onion1", :item_description => "Onion1", :price => 2.0, :dimension => "Box", :created_at => "2013-02-08 11:52:35", :updated_at => "2013-02-08 11:52:35" },
  { :item_name => "Orange1", :item_description => "Orange1", :price => 10.0, :dimension => "Box", :created_at => "2013-02-08 11:58:18", :updated_at => "2013-02-08 11:58:18" },
  { :item_name => "Onion1", :item_description => "Onion1", :price => 2.0, :dimension => "Box", :created_at => "2013-02-08 11:58:18", :updated_at => "2013-02-08 11:58:18" }
], :without_protection => true )



Order.create([
  { :order_number => "000003", :total_price => 10.0, :total_num_of_items => 5, :max_discount => 0.0, :delivery_date => "2013-02-08", :status => "Ordered", :user_id => nil, :role => "Administrator", :date_of_ordering => "2013-02-08", :pref_delivery_date => "2013-02-08", :credit_card_type => "MasterCard", :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-08 11:52:35", :updated_at => "2013-02-08 11:52:35" },
  { :order_number => "000003", :total_price => 10.0, :total_num_of_items => 5, :max_discount => 0.0, :delivery_date => "2013-02-08", :status => "Ordered", :user_id => nil, :role => "Administrator", :date_of_ordering => "2013-02-08", :pref_delivery_date => "2013-02-08", :credit_card_type => "MasterCard", :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-08 11:58:18", :updated_at => "2013-02-08 11:58:18" },
  { :order_number => "00007", :total_price => 1020.0, :total_num_of_items => 12, :max_discount => nil, :delivery_date => nil, :status => "Ordered", :user_id => nil, :role => nil, :date_of_ordering => "2010-02-12", :pref_delivery_date => nil, :credit_card_type => nil, :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-11 20:12:53", :updated_at => "2013-02-11 20:12:53" },
  { :order_number => "12121", :total_price => 1020.0, :total_num_of_items => 12, :max_discount => nil, :delivery_date => nil, :status => "Ordered", :user_id => nil, :role => nil, :date_of_ordering => "2010-02-12", :pref_delivery_date => nil, :credit_card_type => nil, :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-12 10:28:53", :updated_at => "2013-02-12 10:28:53" },
  { :order_number => "00009", :total_price => 1020.0, :total_num_of_items => 12, :max_discount => nil, :delivery_date => nil, :status => "Ordered", :user_id => nil, :role => nil, :date_of_ordering => "2010-02-12", :pref_delivery_date => nil, :credit_card_type => nil, :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-13 07:28:54", :updated_at => "2013-02-13 07:28:54" },
  { :order_number => "01011", :total_price => 1020.0, :total_num_of_items => 12, :max_discount => nil, :delivery_date => nil, :status => "Ordered", :user_id => nil, :role => nil, :date_of_ordering => "2010-02-12", :pref_delivery_date => nil, :credit_card_type => nil, :credit_card_number => nil, :cvv2 => nil, :expiry_date => nil, :start_date => nil, :issue_number => nil, :created_at => "2013-02-13 07:50:25", :updated_at => "2013-02-13 07:50:25" }
], :without_protection => true )



OrderItem.create([
  { :item_id => 3, :quantity => 1, :price_per_line => 50.0, :created_at => "2013-02-08 11:58:19", :updated_at => "2013-02-08 11:58:19", :order_id => 2 },
  { :item_id => 2, :quantity => nil, :price_per_line => 20.0, :created_at => "2013-02-08 11:58:19", :updated_at => "2013-02-13 18:13:55", :order_id => 2 },
  { :item_id => 5, :quantity => 5, :price_per_line => 5.0, :created_at => "2013-02-13 18:56:36", :updated_at => "2013-02-13 18:56:36", :order_id => 1 },
  { :item_id => 4, :quantity => 55, :price_per_line => 550.0, :created_at => "2013-02-13 20:29:34", :updated_at => "2013-02-13 20:29:34", :order_id => 1 },
  { :item_id => 1, :quantity => 3, :price_per_line => 30.0, :created_at => "2013-02-13 20:33:35", :updated_at => "2013-02-13 20:33:35", :order_id => 1 },
  { :item_id => 3, :quantity => 33, :price_per_line => 330.0, :created_at => "2013-02-13 20:39:19", :updated_at => "2013-02-13 20:39:19", :order_id => 1 }
], :without_protection => true )



User.create([
  { :created_at => "2013-01-28 12:35:32", :updated_at => "2013-02-13 07:26:06", :last_name => "dfdfdCatovich", :email => "sezya.kot@gmail.com", :first_name => "Catdfg", :region => "South", :role => "Administrator", :login_name => "kot", :encrypted_password => "$2a$10$7QnEmcHWY3wtrvRveXkVM.GBjdE2Ri/pa6uc8fLZIUFYEVjO6jyvy", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 19, :current_sign_in_at => "2013-02-13 07:25:41", :last_sign_in_at => "2013-02-03 19:15:16", :current_sign_in_ip => "127.0.0.1", :last_sign_in_ip => "127.0.0.1", :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:49:53", :updated_at => "2013-01-28 12:50:46", :last_name => "Miay", :email => "fwer@df.miay", :first_name => "Murzik_one", :region => "South", :role => "Customer", :login_name => "cat123", :encrypted_password => "$2a$10$Ztd2W3mmJMJJRDQfs.p4Q.fpd8a1oblzAdW7H8CYbxs9PyenHfYHu", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:51:30", :updated_at => "2013-01-28 12:51:30", :last_name => "ngsdg", :email => "sdfgasd@gsdg.ru", :first_name => "asga", :region => "South", :role => "Administrator", :login_name => "eefasdf", :encrypted_password => "$2a$10$nlod9hSa8JGXEw5BJj.LtOvZ1asDabDXXK2LGHvvFjMgGGoG7d7G2", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:51:52", :updated_at => "2013-01-28 12:51:52", :last_name => "jkvd", :email => "ghs@wdg.ru", :first_name => "gsdgb", :region => "South", :role => "Administrator", :login_name => "esdgasg", :encrypted_password => "$2a$10$HR2FmPOyFGP3dcNqGT8r2u1u8Rqe02hIQ93MX5jK56bySho2Q.XqO", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:52:18", :updated_at => "2013-01-28 12:52:18", :last_name => "gjksbgh", :email => "bggas@er.ri", :first_name => "gbjsfgbsg", :region => "South", :role => "Administrator", :login_name => "egvbj", :encrypted_password => "$2a$10$cmzTGf7rqhOotAGWzFTjJus17sOkSJ/lEZJ/8cPmMPam.LnPDZNYm", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:53:40", :updated_at => "2013-01-28 12:53:40", :last_name => "FGBSDFG", :email => "wett@sgsdg.ru", :first_name => "sdfgsdfh", :region => "South", :role => "Administrator", :login_name => "efhg", :encrypted_password => "$2a$10$BC3QeYoFA4TtJhAzeFZEp.KtsFzkNpq16OdQAjNQG5x/X3AyM3vQm", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:54:01", :updated_at => "2013-01-28 12:54:01", :last_name => "fnjkl;hngf", :email => "sdfgbs@sdfg.ry", :first_name => "hlsdkhn", :region => "South", :role => "Administrator", :login_name => "eknhl", :encrypted_password => "$2a$10$9g68Qa8NQiNx2yhnaNsrCOBIg7l4yWwJ2RB3w811AXR.8mxmoJMzK", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:54:27", :updated_at => "2013-01-28 12:54:27", :last_name => "njdfh", :email => "dasf@dgsg.ru", :first_name => "fn", :region => "South", :role => "Administrator", :login_name => "egnkdfh", :encrypted_password => "$2a$10$deF8VzHFuZeHt7GbPAsg3u0nnxKo7WDsgJrgpIFJ4pQsYmm2IaaSq", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:54:46", :updated_at => "2013-01-28 12:54:46", :last_name => "bjhdg", :email => "jkgnsd@fbg.ru", :first_name => "jkdfsg", :region => "South", :role => "Administrator", :login_name => "enfnghd", :encrypted_password => "$2a$10$UiuhvmNdpcQiwY1P6eBr1Olfhb0BTQoQdcBCkx9g9GVd.f9wyUxmm", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:55:30", :updated_at => "2013-01-28 12:55:30", :last_name => "dfsldg", :email => "dgjksg@fhsg.ry", :first_name => "nsfjlkgn", :region => "South", :role => "Administrator", :login_name => "esfghsdfg", :encrypted_password => "$2a$10$XSzlVl/dXKfZaHCRrAKYUOqVfWSI8cyxLu0USrfz4dcMPpJLnA.hm", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:56:17", :updated_at => "2013-01-28 12:56:17", :last_name => "sfjkgb", :email => "jgsdg@fsg.er", :first_name => "ghdf", :region => "South", :role => "Administrator", :login_name => "esdg", :encrypted_password => "$2a$10$dp57K.x3RR82ONU9kd57U.YW0Qz5K8PVUAqN8791vnXfDiQxp6fnW", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:56:33", :updated_at => "2013-01-28 12:56:33", :last_name => "fgjsbg", :email => "gfjgb@dfg.eu", :first_name => "bdg", :region => "South", :role => "Administrator", :login_name => "emgsdjg", :encrypted_password => "$2a$10$hbCuKqXZVB5YEZ6o40jwx.ZN.NQxzWVhwX.43corz/O3WdcrZkblO", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:56:51", :updated_at => "2013-01-28 12:56:51", :last_name => "sjkfnglkd", :email => "dsfsdf@fgsmwe.rl", :first_name => " fbsdf", :region => "South", :role => "Administrator", :login_name => "esdgb", :encrypted_password => "$2a$10$pwbADpVuc3ltZIzm2AinPuBzkUGEMjZVmJjGmKme.TQsVW0hig6V.", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 12:57:07", :updated_at => "2013-01-28 12:57:07", :last_name => "dskgnsd", :email => "dsghasdf@dfms.er", :first_name => "ndfjk", :region => "South", :role => "Administrator", :login_name => "ejdgb", :encrypted_password => "$2a$10$WUH6Lwefo2mWFWkTMUPIXuXkYEzvOA3t3Cra88/m5ALLtd9dgIL0y", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 13:03:58", :updated_at => "2013-01-28 13:03:58", :last_name => "jdgjf", :email => "fgsd@sdfg.eu", :first_name => "dfj", :region => "South", :role => "Administrator", :login_name => "fjkj", :encrypted_password => "$2a$10$TuF9QUroCGXp8t3mRkQ43.wPO22lyk7.gc3qjGHTQyyXQpQv8RB7W", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 13:04:15", :updated_at => "2013-01-28 13:04:15", :last_name => "ajfg", :email => "fgsdg@dfgsd.ru", :first_name => "sfdg", :region => "South", :role => "Administrator", :login_name => "ghdhf", :encrypted_password => "$2a$10$veSxKaGkVdWmg6Ll5gTGQ.qcgZQZAYQ9TRDm4ARp5ldfJWwqh1HL6", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 15:09:19", :updated_at => "2013-01-28 15:09:19", :last_name => "dfdfdCatovich", :email => "sezya.kot@gmail.com", :first_name => "Cat", :region => "South", :role => "Customer", :login_name => "dcvdv", :encrypted_password => "$2a$10$tE5Qou.YQ9alH2DnnhhAL.0zWB4gV87p9c6d.k0utxaTkYhiw/y12", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 15:26:35", :updated_at => "2013-01-28 15:26:35", :last_name => "dfdfdCatovich", :email => "sezya.kot@gmail.com", :first_name => "Catdfg", :region => "South", :role => "Merchandiser", :login_name => "cgeer", :encrypted_password => "$2a$10$rY6qarhkgxNfD2UTxEEFvetUY.3B3OIXRa2JkzhtfmnP6sHBxogEi", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 15:27:12", :updated_at => "2013-01-28 15:27:12", :last_name => "dfg", :email => "dsfdsf@gmail.com", :first_name => "dfg", :region => "South", :role => "Merchandiser", :login_name => "dfg", :encrypted_password => "$2a$10$kK4ac59gSSnU7l4jiqwaZOZ4ycAb4gGaH48tAwQ.QiyRgPln.rHNy", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-28 15:28:10", :updated_at => "2013-01-28 15:28:10", :last_name => "sdf", :email => "dsfdsf@gmail.com", :first_name => "so", :region => "South", :role => "Administrator", :login_name => "why", :encrypted_password => "$2a$10$cMfv9LRjVoAhKV37YcjH5eN6foxGJD5o6Tf5bXEEMrqTJ/9rD5mDO", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-30 14:27:58", :updated_at => "2013-01-30 14:36:50", :last_name => "wer", :email => "asd@gmail.com", :first_name => "ewrEE", :region => "South", :role => "Customer", :login_name => "ar", :encrypted_password => "$2a$10$2h1qrkgi/inhFqkSsSeDTuSZhI6DTQ0q3yjTCYNF0MFAT7tYmQsBW", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-30 14:45:03", :updated_at => "2013-01-30 14:45:03", :last_name => "asdf", :email => "af@gmail.com", :first_name => "asd", :region => "West", :role => "Administrator", :login_name => "asdd", :encrypted_password => "$2a$10$Uh34GOuA93Oiqd1ChMiL9elTMa5bbpMh9hJ/.WcAE0mSKqlDNQQOq", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-01-30 14:48:28", :updated_at => "2013-01-30 14:48:28", :last_name => "sdfdf", :email => "asdfdsfsd@gmail.com", :first_name => "sdc", :region => "South", :role => "Supervisor", :login_name => "sdcsdfdsfds", :encrypted_password => "$2a$10$uBF0oEfGRPOLCbChzy0bi.Z0SB/KMBYxvhKwMFGq4oBt9X3UT37Ce", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-02-01 11:07:00", :updated_at => "2013-02-01 11:07:00", :last_name => "kot", :email => "sezya.kot@gmail.com", :first_name => "kot", :region => "South", :role => "Administrator", :login_name => "kott", :encrypted_password => "$2a$10$J4Yc8WX9e1paUdiqS3DGwuVokW7/CfgmVibqY7QlcQyvXceqTLFhW", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-02-04 20:45:10", :updated_at => "2013-02-13 20:56:43", :last_name => "Phoenix", :email => "pointhomefinal@gmail.com", :first_name => "Black", :region => "West", :role => "Administrator", :login_name => "blackening", :encrypted_password => "$2a$10$tEiI54hHaFs7GJoGFRQEKOl3WzkQUwophdwFGJYI5mHoZGzNL5w7K", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 35, :current_sign_in_at => "2013-02-13 20:56:15", :last_sign_in_at => "2013-02-11 20:19:39", :current_sign_in_ip => "127.0.0.1", :last_sign_in_ip => "127.0.0.1", :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-02-04 20:46:35", :updated_at => "2013-02-13 07:26:21", :last_name => "Omer", :email => "ololoimriderufo@gmail.com", :first_name => "Mr Cust", :region => "North", :role => "Customer", :login_name => "customer", :encrypted_password => "$2a$10$MGWBNyJxHd.WtMNrrxyub.7BxNynvypiyY9pjlj37vGS4mPzoQhjW", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 15, :current_sign_in_at => "2013-02-13 07:26:21", :last_sign_in_at => "2013-02-11 20:23:01", :current_sign_in_ip => "127.0.0.1", :last_sign_in_ip => "127.0.0.1", :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-02-03 13:04:28", :updated_at => "2013-02-03 22:59:39", :last_name => "chumak", :email => "chumako@mail.ru", :first_name => "olga", :region => "South", :role => "Customer", :login_name => "olga", :encrypted_password => "$2a$10$N9fXUUOYjaewhZzz2y5GjeZz0xL9HevJ46bw9j9vuFV7Ya.fSvrM2", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 29, :current_sign_in_at => "2013-02-03 22:59:39", :last_sign_in_at => "2013-02-03 19:16:36", :current_sign_in_ip => "127.0.0.1", :last_sign_in_ip => "192.168.139.1", :failed_attempts => 0, :locked_at => nil },
  { :created_at => "2013-02-11 20:20:18", :updated_at => "2013-02-11 20:21:57", :last_name => "darkBAAARRR", :email => "dsfd@Gmail.com", :first_name => "darkFOOO", :region => "South", :role => "Merchandiser", :login_name => "park", :encrypted_password => "$2a$10$puCmXbc6D.WbhlbqyOzhperWZACU6/xpYAqUkdqkuTLJsNJak5LNa", :reset_password_token => nil, :reset_password_sent_at => nil, :remember_created_at => nil, :sign_in_count => 0, :current_sign_in_at => nil, :last_sign_in_at => nil, :current_sign_in_ip => nil, :last_sign_in_ip => nil, :failed_attempts => 0, :locked_at => nil }
], :without_protection => true )



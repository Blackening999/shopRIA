class Order < ActiveRecord::Base
  belongs_to :user  
  has_many :order_items
  has_many :items, :through => :order_items, :dependent => :destroy

  attr_accessible :credit_card_number,
                  :credit_card_type, 
                  :cvv2, 
                  :date_of_ordering, 
                  :delivery_date, 
                  :expiry_date, 
                  :issue_number, 
                  :max_discount, 
                  :order_number, 
                  :pref_delivery_date, 
                  :role, 
                  :start_date, 
                  :status, 
                  :total_num_of_items, 
                  :total_price

  validates :order_number,       :presence => true, :uniqueness => true  
  #validates :credit_card_type,   :presence => true  
  #validates :credit_card_number, :presence => true, :length => {:is => 16}
  #validates :cvv2,               :presence => true, :length => {:is => 3}
  #validates :expiry_date,        :presence => true
  #validates :issue_number,       :length => {:is => 1}
          

  default_scope -> { order("id asc") }

  scope :filter_by, lambda { |field, query| where(
        "#{field} LIKE '#{query}'"
    )
  }
  
  paginates_per 5
end
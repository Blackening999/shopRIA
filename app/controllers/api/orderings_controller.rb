class OrderingsController < ApplicationController
  respond_to :html, :json

  def index
    @orders = Order.all  
 
    respond_to do |format|
      format.html
      format.json do
        respond_with({ models: @orders })
      end
    end 
  end

  
  def show
    @order = Order.find(params[:id]) 
   
    total = Order.select("sum(total_price) as total_price").where(user_id:@order.user_id)    
    total = total[0][:total_price]
    
    customer_type = case total
      when 0..1000 then "Standard"
      when 1001..3000 then "Silver"
      when 3001..10000 then "Gold"
      when 10001..10000000 then "Platinum"    
    end

    user = User.find @order[:user_id]
    
    @order[:login_name] = user[:login_name]
    @order[:customer_type] = customer_type
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  
  # PUT /orderings/1
  # PUT /orderings/1.json
  def update
     
    @order = Order.find params[:id]
   
    @order.update_attributes :status => params[:status]
    @order.update_attributes :delivery_date => params[:delivery_date]

    respond_to do |format|
      format.html
      format.json { respond_with @order }
    end
  end
  
  
end

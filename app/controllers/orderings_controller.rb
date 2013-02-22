class OrderingsController < ApplicationController
  respond_to :html, :json

  def index
    @orders = Order.all

    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @orderings }
    # end

    Order.select("user_id as user_id, sum(total_price) as total_price").group("user_id")

    respond_to do |format|
      format.html
      format.json do
        respond_with({ models: @orders, customer: @customer })
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

    @order[:total] = total
    @order[:customer_type] = customer_type

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order }
    end
  end

  # GET /orderings/new
  # GET /orderings/new.json
  def new
    @ordering = Ordering.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @ordering }
    end
  end

  # GET /orderings/1/edit
  def edit
    @ordering = Ordering.find(params[:id])
  end

  # POST /orderings
  # POST /orderings.json
  def create
    @ordering = Ordering.new(params[:ordering])

    respond_to do |format|
      if @ordering.save
        format.html { redirect_to @ordering, notice: 'Ordering was successfully created.' }
        format.json { render json: @ordering, status: :created, location: @ordering }
      else
        format.html { render action: "new" }
        format.json { render json: @ordering.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /orderings/1
  # PUT /orderings/1.json
  def update
    @ordering = Ordering.find(params[:id])

    respond_to do |format|
      if @ordering.update_attributes(params[:ordering])
        format.html { redirect_to @ordering, notice: 'Ordering was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @ordering.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orderings/1
  # DELETE /orderings/1.json
  def destroy
    @ordering = Ordering.find(params[:id])
    @ordering.destroy

    respond_to do |format|
      format.html { redirect_to orderings_url }
      format.json { head :no_content }
    end
  end
end

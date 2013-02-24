class OrdersController < ApplicationController
  respond_to :html, :json

  def index
    if params[:filter_by]
      @orders = Order.filter_by(params[:filter_by], params[:filter_options])
      if params[:request] != ""
        @orders = @orders.filter_by(params[:filter_by], params[:request])
      end
    else  
      @orders = Order.scoped
    end

    @orders = @orders.reorder(params[:orderBy]).page(params[:page]).per(params[:pp])

    @pagination = {
      page:         @orders.current_page,
      num_pages:    @orders.num_pages,
      pp:           @orders.limit_value,
      total_count:  Order.count,
    }
    #@order = current_user.orders.create params[:order] in FUTURE
    
    respond_to do |format|
      format.html
      format.json do
        respond_with({ models: @orders }.merge @pagination)
      end
    end
  end

  def show
    @order = Order.find(params[:id])       
    
    #@all_items = @order.items.select("item_id,item_name,item_description,dimension,price,quantity,price_per_line")
    
    respond_to do |format|
      format.html # show.html.erb      
      format.json { render json: @order }
      #format.json { render json: { order: @order, order_items: @all_items.to_json().html_safe } }
    end
  end 
   def create
    @order = Order.create params[:order]
    respond_to do |format|
      format.html { redirect_to user_path(@order) }
      format.json { respond_with @order }
    end
  end
  def update
    @order = Order.find params[:id]
    @order.update_attributes params[:order]
    respond_to do |format|
      format.html
      format.json { respond_with @order }
    end
  end

  def destroy
    respond_with Order.destroy(params[:id])
  end
end
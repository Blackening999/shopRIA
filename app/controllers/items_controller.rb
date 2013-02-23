class ItemsController < ApplicationController
  respond_to :html, :json

  def index
  #  @items = if params[:request]
      #fields = if params[:fields] == "all_columns"
      #  %w(login_name first_name last_name role)
      #else
      #  params[:fields] 
     # end
     # item.send params[:scope].intern, fields, params[:request]
  #  else
   #   item.scoped
   # end

   # @items = @items.reorder(params[:itemBy]).page(params[:currentPage]).per(params[:perPage])

   # @pagination = {
      #current_page: @items.current_page,
      #num_pages:    @items.num_pages,
     # per_page:     @items.limit_value,
     # total_count:  item.count,
   # }
    @items = Item.all
    
    respond_to do |format|
      format.html
      format.json do
        respond_with({ models: @items })#}.merge @pagination)
      end
    end
  end

  def show
    @item = Item.find(params[:id])       
          
    respond_to do |format|
      format.html # show.html.erb      
      format.json { render json: @all_items }
      #format.json { render json: { item: @item, item_items: @all_items.to_json().html_safe } }
    end
  end
  
  def create
    @item = Item.create params[:item]
    respond_to do |format|
      format.html { redirect_to user_path(@item) }
      format.json { respond_with @item }
    end
  end

  def update
    @item = Item.find params[:id]
    @item.update_attributes params[:item]
    respond_to do |format|
      format.html
      format.json { respond_with @item }
    end
  end

  def destroy
    respond_with Item.destroy(params[:id])
  end
end
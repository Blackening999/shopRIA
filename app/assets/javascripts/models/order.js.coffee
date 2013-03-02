class Shop.Models.Order extends Backbone.Model
  url: ->
    if @id?
      "/api/orders/#{@id}"
    else
      "/api/orders"      

  # initialize: ->
  #   if @id?     
  #     @order_items = new Shop.Collections.OrderItems({order_id: @id})       
  #   else
  #     @order_items = new Shop.Collections.OrderItems() 
      

  # order_items: ->
  #   unless @_order_items?
  #     if @id?     
  #       @order_items = new Shop.Collections.OrderItems({order_id: @id})               
  #     else
  #       @order_items = new Shop.Collections.OrderItems()       
  #   @_order_items 

  # items: ->
  #   unless @_items?
  #     @_items = new Shop.Collections.Items({order_id: @id})
  #     @_items.fetch()
  #   @_items   



  
    

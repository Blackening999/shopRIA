class Shop.Models.OrderItem extends Backbone.Model
  
  url: ->
    if @id?
      "/api/orders/#{@get("order_id")}/order_items/#{@id}"
    else
      "/api/orders/#{@get("order_id")}/order_items"

      
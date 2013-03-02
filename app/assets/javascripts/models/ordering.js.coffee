class Shop.Models.Ordering extends Backbone.Model
  url: ->
    if @id?
      "/api/orderings/#{@id}"
    else
      "/api/orderings"

  initialize: ->
    @order_items = new Shop.Collections.OrderItems({order_id: @id})   
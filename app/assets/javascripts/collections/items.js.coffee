class Shop.Collections.Items extends Backbone.Collection

  model: Shop.Models.Item
  #totalPrice: 0
  #itemStore: {}
  #itemsStore: []
  url: '/api/items'

  # initialize: (order_id) ->
  #   @order_id = order_id
  #   if order_id?
  #     @url += '/' + order_id.order_id + '/items'

  parse: (resp) =>
    #@init_pagination(resp)
    resp["models"]  


  # tempAdd: (order_item) ->
  #   @itemsStore.push order_item
  #   @totalPrice += Number(order_item.attributes.price_per_line)
  #   {price:    @totalPrice, 
  #   totalNum:  @itemsStore.length}   
    

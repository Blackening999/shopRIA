class Shop.Collections.Items extends Backbone.Collection

  model: Shop.Models.Item
  totalPrice: 0
  itemStore: {}
  id: 0
  #ordNum: 0
  url: '/api/items'
  
  # initialize: (order_id) ->
  #   @order_id = order_id
  #   if order_id?
  #     @url += '/' + order_id.order_id + '/items'

  parse: (resp) =>
    #@init_pagination(resp)
    resp["models"]  

  countPrice: (attrs) ->
    @totalPrice += Number(attrs.price_per_line)
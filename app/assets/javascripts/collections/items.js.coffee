class Shop.Collections.Items extends Backbone.Collection

  model: Shop.Models.Item

  url: '/api/items'

  # initialize: (order_id) ->
  #   @order_id = order_id
  #   if order_id?
  #     @url += '/' + order_id.order_id + '/items'

  parse: (resp) =>
    #@init_pagination(resp)
    resp["models"]

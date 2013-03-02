class Shop.Collections.Orderings extends Backbone.Collection

  model: Shop.Models.Ordering

  url: '/api/orderings'

  parse: (resp) =>
    #@init_pagination(resp)
    resp["models"]  
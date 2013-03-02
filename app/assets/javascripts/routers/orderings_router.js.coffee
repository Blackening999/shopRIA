class Shop.Routers.Orderings extends Backbone.Router
  routes:
    "orderings(/)"                           : "index"
    "orderings/:id/edit(/)"                  : "edit"
                 
  initialize: ->
    @collection = new Shop.Collections.Orderings()    
    @collection.fetch()         
    
  index: ->
    view = new Shop.Views.OrderingsIndex(collection: @collection)    
    $('#merchandiser').html(view.render().el)

  edit: (id) ->     
    order = new Shop.Models.Ordering({id:id})
    order.fetch()    
    view = new Shop.Views.OrderingsEdit(model: order)
    

 
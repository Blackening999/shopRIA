class Shop.Routers.Items extends Backbone.Router
  routes:
    "items(/)"         : "index"
    "items/new(/)"     : "newItem"
    "items/:id/edit(/)": "edit"
     
  initialize: ->
    @collection = new Shop.Collections.Items()
    @collection.fetch()       
    
  index: ->
    view = new Shop.Views.ItemsIndex(collection: @collection)
    $('#supervisor').html(view.render().el)  
    
  newItem: ->
    item = new Shop.Models.Item()    
    view = new Shop.Views.ItemsNew(model: item,collection: @collection)
  
  edit: (id) ->
    item = @collection.get(id)
    view = new Shop.Views.ItemsEdit({model: item})
  
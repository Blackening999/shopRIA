class Shop.Views.OrderingsItemsItem extends Backbone.View

  template: JST['orderings/item']
  tagName: 'tr'

  events:
    'click #edit'   : 'goToEdit'
    'click #destroy' : 'destroy' 
   
  render: ->
    $(@el).html(@template(item: @model))
    @

  goToEdit: ->   
    order_id = Number(@model.collection.order_id.order_id)
    Backbone.history.navigate("orders/" + order_id + "/order_items/" + @model.get("id") + "/items", true)

  destroy: ->    
    @model.collection.removedOrderItems.push @model 
    @model.collection.remove(@model)
    $(@el).remove()
    #@model.destroy() #if confirm 'Are you sure you want to delete this item?'
    
    
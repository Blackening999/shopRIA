class Shop.Views.OrderItemsItem extends Backbone.View

  template: JST['order_items/item']
  tagName: 'tr'

  events:
    'click #edit'   : 'goToEdit'
    'click #destroy': 'destroy' 
   
  render: ->
    $(@el).html(@template(item: @model))
    @

  goToEdit: ->   
    order_id = Number(@model.collection.order_id.order_id)
    Backbone.history.navigate("orders/" + order_id + "/order_items/" + @model.get("id") + "/items", true)

  destroy: ->
    #order_id = @model.collection.order_id.order_id
    $(@el).remove()
    #@model['url'] =  "/api/orders/" + order_id + "/order_items/" + @model.get("id")
    @model.destroy() #if confirm 'Are you sure you want to delete this item?'
class Shop.Views.OrderItemsItem extends Backbone.View

  template: JST['order_items/item']
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
    _.each @collection.itemsStore, (tempModel, index) =>
      if @model.cid == tempModel.cid
        @collection.totalPrice -= Number(tempModel.attributes.price_per_line)
        @collection.itemsStore.splice(index, 1)
    console.log @collection
    $('#total_price').text(@collection.totalPrice)
    $('#total_num_of_items').text(@collection.itemsStore.length)
    $(@el).remove()
    @model.destroy() #if confirm 'Are you sure you want to delete this item?'
    
    
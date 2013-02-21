class Shop.Views.OrderItemsItem extends Backbone.View

  template: JST['order_items/item']
  tagName: 'tr'

  events:
    'click #destroy'  : 'destroy' 
    'click #edit'     : 'edit'
       
  initialize: ->
    @model.on('change', @render, @)

  render: ->
    $(@el).html(@template(item: @model))
    @

  edit: ->
    @collection.cid = @model.cid

  destroy: ->
    _.each @collection.itemsStore, (tempModel, index) =>
      if @model.cid == tempModel.cid
        @collection.totalPrice -= Number(tempModel.attributes.price_per_line)
        @collection.itemsStore.splice(index, 1)
    $('#total_price').text(@collection.totalPrice)
    $('#total_num_of_items').text(@collection.itemsStore.length)
    $(@el).remove() #if confirm 'Are you sure you want to delete this item?'
    @model.destroy() 
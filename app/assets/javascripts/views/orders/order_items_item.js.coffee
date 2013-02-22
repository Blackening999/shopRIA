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
    @collection.id = @model.id

  destroy: ->
    $(@el).remove() if confirm 'Are you sure you want to delete this item?'
    #if confirm 'Are you sure you want to delete this item?'
    @collection.totalPrice -= Number(@model.attributes.price_per_line)
    $('#total_price').text(@collection.totalPrice)
    $('#total_num_of_items').text(@model.collection.length-1)
    @model.destroy() 


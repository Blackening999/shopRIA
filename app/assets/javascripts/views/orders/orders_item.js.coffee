class Shop.Views.OrdersItem extends Backbone.View

  template: JST['orders/item']
  tagName: 'tr'  
  
  #initialize: ->
  #  @collection.on('reset', @render, @)
  
  render: ->
    $(@el).html(@template(item: @model))    
    @  
    
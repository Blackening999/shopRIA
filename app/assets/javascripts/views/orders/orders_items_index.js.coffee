class Shop.Views.OrdersItemsIndex extends Backbone.View

  tagName: 'table'
  id: "items_table"
  className: "table table-condensed"
  template: JST['order_items/index']
  

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)

  render: ->
    $(@el).html(@template(order_items: @collection)) 
    @collection.each(@appendOrderItem) 
    @

  appendOrderItem: (order_item) =>
    #console.log order_item
    #if typeof(order_item.get('order_id'))=="undefined"      
    view = new Shop.Views.OrderItemsItem(model: order_item)
    @$('tbody').append(view.render().el)		
class Shop.Views.OrderingsIndex extends Backbone.View

  template: JST['orderings/index']

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)
   
  render: ->
    $(@el).html(@template(orders: @collection))
    @collection.each(@appendOrder)
    @

  appendOrder: (order) =>
    view = new Shop.Views.OrderingsOrder(model: order)
    @$('tbody').append(view.render().el)
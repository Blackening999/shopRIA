class Shop.Views.OrdersOrder extends Backbone.View

  template: JST['orders/order']
  tagName: 'tr'

  events:
    'click #edit'   : 'goToEdit'
    'click #destroy': 'destroy' 
   
  render: ->
    $(@el).html(@template(order: @model))
    @

  goToEdit: ->   
    Backbone.history.navigate("orders/#{@model.get('id')}/edit", true)

  destroy: ->
    @model['url'] = "/api/orders/#{@model.get('id')}"
    @model.destroy() if confirm 'The order will be deleted from the List of Orders. Are you sure you want to proceed?'    

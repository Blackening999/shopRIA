class Shop.Views.OrderingsOrder extends Backbone.View

  template: JST['orderings/order']
  tagName: 'tr'

  events:
    'click #edit'   : 'goToEdit'   
   
  render: ->
    $(@el).html(@template(order: @model))
    @

  goToEdit: ->   
    Backbone.history.navigate("orderings/#{@model.get('id')}/edit", true) 
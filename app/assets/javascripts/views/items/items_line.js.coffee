class Shop.Views.ItemsLine extends Backbone.View

  template: JST['items/line']
  tagName: 'tr'

  events:
    'click #edit'   : 'goToEdit'
    'click #destroy': 'destroy' 
   
  render: ->
    $(@el).html(@template(item: @model))
    @

  goToEdit: ->   
    Backbone.history.navigate("items/#{@model.get('id')}/edit", true)

  destroy: ->
    #@model['url'] = "/api/orders/#{@model.get('id')}"
    #@model.destroy() if confirm 'The order will be deleted from the List of Orders. Are you sure you want to proceed?'    
    alert "Item will get status out of stock"

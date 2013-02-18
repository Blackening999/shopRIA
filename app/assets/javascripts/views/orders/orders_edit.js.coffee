class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:
    'click .backbone'     : 'navigateLink' 
    'click #addItemLink'  : 'addItemLink'
    'click #cancel'       : 'returnOnMain' 

  initialize: ->
    @model.on('change', @render, @) 
    @render()
    @fillTable()

  render: ->    
    $(@el).html(@template(order: @model, pageInfo: @collection.pageInfo() ))    
    @

  navigateLink: (event) ->
    event.preventDefault()
    Backbone.history.navigate(event.target.attributes["href"].value, true)     
    false

  addItemLink: (event) ->
    #log.console event.target.attributes["href"].value
    Backbone.history.navigate("orders/#{@model.get('id')}/items", true)
    #Backbone.history.navigate(event.target.attributes["href"].value, true) 
    false  

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true)
    
  fillTable: ->  
    view = new Shop.Views.OrdersItemsIndex(collection: @model.order_items())    
    $(@el).find('#table_order_items').html(view.render().el)   
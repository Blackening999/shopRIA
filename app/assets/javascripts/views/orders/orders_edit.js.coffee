class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:
    'click .backbone'     : 'navigateLink' 
    'click #cancel'       : 'returnOnMain'
    'click .item_line'    : 'selectItem'
    'click #addItem'      : 'addItem' 
   
  initialize: ->
    @model.on('change', @render, @)  
    @itemsLoad()   
    @render()
      
  render: ->    
    $(@el).html(@template(order: @model, pageInfo: @collection.pageInfo()))    
    @

  itemsLoad: ->
    @items = new Shop.Collections.Items()
    @items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          view = new Shop.Views.ItemsItem (model: model, collection: @items)                 
          $('#items tbody').append view.render().el 
    @collection.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          orderView = new Shop.Views.OrderItemsItem(model: model)
          @$('#items_table tbody').append(orderView.render().el)
    @render()
   
  selectItem: ->
    itm = @items.itemStore
    itmName = itm["item_name"]
    itmPrice = Number(itm["price"])
    $(@el).find('#item_name').text(itmName)
    $(@el).find('#price').text(itmPrice)
    $(@el).find('#quantity').val(1)  


  addItem: (e) =>
    e.preventDefault()
    itm = @items.itemStore
    itm["quantity"] = Number($(@el).find('#quantity').val())
    itm["dimension"] = $(@el).find('#dimension :selected').val()
    switch itm["dimension"]
      when "Item"    then itm["price"] = itm["price"]*itm["quantity"]
      when "Box"     then itm["price"] = itm["price"]*itm["quantity"]*5
      when "Package" then itm["price"] = itm["price"]*itm["quantity"]*10
    itmQ =
      order_id: Number(@order_id)
      item_id: itm["id"] 
      quantity: itm["quantity"]
      dimension: itm["dimension"]
      price_per_line: itm["price"] 
    order_item = new Shop.Models.OrderItem(itmQ)
    view = new Shop.Views.OrderItemsItem(model: order_item)
    @$('#items_table tbody').append(view.render().el)
    #@collection.create itmQ,
      #success: ->
        #wait: true
        #$(@el).find('#myModal').attr('data-dismiss', 'modal')
        #$(@el).find('#myModal').attr('aria-hidden', 'true')
    
  navigateLink: (event) ->
    event.preventDefault()
    Backbone.history.navigate(event.target.attributes["href"].value, true)     
    false
  
  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true) 
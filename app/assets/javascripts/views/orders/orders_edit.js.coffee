class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:
    'click .backbone'     : 'navigateLink' 
    'click #addItemLink'  : 'addItemLink'
    'click #cancel'       : 'returnOnMain'
    'click .item_line'    : 'selectItem'
    'click #addItem'      : 'addItem' 

  initialize: ->
    @model.on('change', @render, @)     
   
    @items = new Shop.Collections.Items({order_id: @model.get('id')})
    @items.fetch
      success: (collection) ->
        console.log "There are now #{collection.length} suggestions in our collection."        
        i = 0
        while i < collection.length
          item = collection.at(i)          
          view = new Shop.Views.ItemsItem (model: item, collection: @items)                 
          $('#items tbody').append view.render().el 
          i++        
      error: (collection, response) ->
        console.log "Sad face! Server says #{response.status}."
    
    @render()
    @fillTable()
    #@fillItems() 

  render: ->    
    $(@el).html(@template(order: @model, pageInfo: @collection.pageInfo()))    
    @

  selectItem: ->
    itm = @items.itemStore
    console.log itm
    itmName = itm["item_name"]
    itmPrice = Number(itm["price"])
    $(@el).find('#item_name').text(itmName)
    $(@el).find('#price').text(itmPrice)
    $(@el).find('#quantity').val(1)  


  addItem: (e) ->
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
    #order_item = new Shop.Models.OrderItem(itmQ)
    #order_item.save()
    @order_items_collection.create itmQ,#order_item
      wait: true
      #success: ->
    #Backbone.history.navigate("/orders/#{@order_id}/edit", true)
    window.history.back() 

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

  fillItems: ->
    @items = @model.items()
    console.log @items
        
     
class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:    
    'submit #edit_order'  : 'editOrder'
    'click .backbone'     : 'navigateLink' 
    'click #cancel'       : 'returnOnMain'
    'click .item_line'    : 'selectItem'
    'click #addItem'      : 'addItem' 
   
  initialize: ->
    @model.on('change', @render, @)      
    @render()
    @orderItemsLoad()   
    @itemsLoad()   
      
  render: ->    
    $(@el).html(@template(order: @model))    
    @

  orderItemsLoad: ->            
    @model.order_items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          orderView = new Shop.Views.OrderItemsItem(model: model, collection:collection)
          @$('#items_table tbody').append(orderView.render().el)
    console.log @model.order_items     
    @render()    

  itemsLoad: ->    
    @model.items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          view = new Shop.Views.ItemsItem (model: model, collection: @items)                 
          $('#items tbody').append view.render().el          
       
  selectItem: ->
    itm = @model.items.itemStore
    itmName = itm["item_name"]
    itmPrice = Number(itm["price"])
    $(@el).find('#item_name').text(itmName)
    $(@el).find('#price').text(itmPrice)
    $(@el).find('#quantity').val(1)  

  addItem: (e) =>
    e.preventDefault()
    itm = @model.items.itemStore
    itm["quantity"] = Number($(@el).find('#quantity').val())
    itm["dimension"] = $(@el).find('#dimension :selected').val()
    switch itm["dimension"]
      when "Item"    then itm["price_per_line"] = itm["price"]*itm["quantity"]
      when "Box"     then itm["price_per_line"] = itm["price"]*itm["quantity"]*5
      when "Package" then itm["price_per_line"] = itm["price"]*itm["quantity"]*10
    itmQ =
      #order_id: Number(@order_id)
      order_id: @model.get('id')
      item_id: itm["id"] 
      quantity: itm["quantity"]
      dimension: itm["dimension"]
      price_per_line: itm["price_per_line"] 
      item_name: itm["item_name"] 
      item_description: itm["item_description"] 
      price: itm["price"] 
    order_item = new Shop.Models.OrderItem(itmQ)    
    @model.order_items.add(order_item)    
    view = new Shop.Views.OrderItemsItem(model: order_item)
    @$('#items_table tbody').append(view.render().el)    
    
  navigateLink: (event) ->
    event.preventDefault()
    Backbone.history.navigate(event.target.attributes["href"].value, true)     
    false
  
  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true) 

  editOrder: (event) ->      
    event.preventDefault()
    attributes =       
      delivery_date: $(@el).find('#delivery_date').text()
      role: $(@el).find('#assignee').val() 
    @model.save attributes,
      wait: true      
      error: @handleError      
    
    _.each @model.order_items.models, (model) ->          
      model.save
        wait: true      
        error: @handleError   

    _.each @model.order_items.removedOrderItems, (model) ->    
      model.destroy
        wait: true      
        error: @handleError       

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages             
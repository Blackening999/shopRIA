class Shop.Views.OrdersNew extends Backbone.View

  el: '#container'

  template: JST['orders/new']

  events:
    'submit #new_order'   : "createOrder"
    'click #cancel'       : 'returnOnMain'
    'click .item_line'    : 'selectItem'
    'click #addItem'      : 'addItem' 

  
  initialize: ->
    @collection.on('add', @render, @)
    @itemsLoad() 
    @render()

  itemsLoad: ->
    @items = new Shop.Collections.Items()
    @items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          view = new Shop.Views.ItemsItem (model: model, collection: @items)                 
          $('#items tbody').append view.render().el
    
  render: ->
    @$el.html(@template())
    @$('form#new_order').validate
       rules:
         order_number: 
           required: true
           maxlength: 5

       messages:
         order_number: 
           required: "Order number cannot be blank!"
           maxlength: "Order number is too long"
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
      when "Item"    then itm["price_per_line"] = itm["price"]*itm["quantity"]
      when "Box"     then itm["price_per_line"] = itm["price"]*itm["quantity"]*5
      when "Package" then itm["price_per_line"] = itm["price"]*itm["quantity"]*10
    itmQ =
      order_id: Number(@order_id)
      item_id: itm["id"] 
      quantity: itm["quantity"]
      dimension: itm["dimension"]
      price_per_line: itm["price_per_line"] 
      item_name: itm["item_name"]
      item_description: itm["item_description"]
      price: itm["price"]
    order_item = new Shop.Models.OrderItem(itmQ)
    view = new Shop.Views.OrderItemsItem(model: order_item)
    @$('#items_table tbody').append(view.render().el)    
    #order_item.save()
    #@order_items_collection.create itmQ,#order_item
    #  wait: true        

  createOrder: (event) ->    
    event.preventDefault()    
    attributes = 
      order_number:       $(@el).find('#order_number').val()
      status:             $(@el).find('#status').text()      
      total_price:        $(@el).find('#total_price').text()      
      total_num_of_items: $(@el).find('#total_num_of_items').text()
      date_of_ordering:   $(@el).find('#date_of_ordering').text()
    @collection.create attributes,
      wait: true
      success: -> 
        $('#new_order')[0].reset()
        Backbone.history.navigate("/orders", true)            
      error: @handleError

  handleError: (order, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true)
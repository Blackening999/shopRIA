class Shop.Views.OrdersNew extends Backbone.View

  el: '#container'

  template: JST['orders/new']

  events:
    'click #save'                    : 'saveOrder'
    'submit #new_order'              : 'createNewOrder'
    'click #cancel'                  : 'returnOnMain'
    'click .item_line'               : 'selectItem'
    'click #editModal .item_line'    : 'selectEditItem'
    'click #addItem'                 : 'addItem' 
    'click #editItem'                : 'editItem'

  
  initialize: ->
    @collection.on('add', @render, @)
    @itemsLoad() 
    @order_items_collection = new Shop.Collections.OrderItems()
    @setDates() 
    @render()
        
  itemsLoad: ->
    @items = new Shop.Collections.Items()
    @items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          view = new Shop.Views.ItemsItem (model: model, collection: @items)                 
          $('#items tbody').append view.render().el
   
  setDates: ->  
    d = new Date()
    d = d.getUTCMonth()+1 + "/" + d.getUTCDate() + "/" + d.getFullYear()
    $(@el).find("#date_of_ordering").text(d)
    $(@el).find("#expiry_date").val(d)

  validateForm: ->    
    @checkDates()     
    
    @$('form#new_order').validate
      rules:
        order_number: 
          required: true           
        credit_card_number:
          required: true
          digits: true
          maxlength: 16     
          minlength: 16
        cvv2:
          required: true
          digits: true
          maxlength: 3     
          minlength: 3
        issue_number:
          digits: true
          maxlength: 1     
          minlength: 1            
          
      messages:
        order_number: 
          required: "Order number cannot be blank!"
        credit_card_number: 
          required: "Credit card number cannot be blank!"
          digits: "Credit card number should contain digits only!"
          maxlength: "Credit card number should contain 16 digits!"     
          minlength: "Credit card number should contain 16 digits!"
        cvv2: 
          required: "cvv2 cannot be blank!"
          digits: "cvv2 should contain digits only!"
          maxlength: "cvv2 should contain 3 digits!"     
          minlength: "cvv2 should contain 3 digits!"
        issue_number:
          digits: "Issue number should contain digits only!"
          maxlength: "Issue number should contain 1 digit"     
          minlength: "Issue number should contain 1 digit"

   checkDates: -> 
    pref_delivery_date = $(@el).find("#pref_delivery_date").val()
    date_of_ordering = $(@el).find("#date_of_ordering").text()
    dateIsInvalid = (new Date(pref_delivery_date).getTime() < new Date(date_of_ordering).getTime())    
    $('#pref_delivery_date').after('<label for="pref_delivery_date" generated="true" class="error">Preferable Delivery Date goes before the Date of Ordering!</label>')  if dateIsInvalid

    expiry_date = $(@el).find("#expiry_date").val()
    start_date = $(@el).find("#start_date").val()
    startDateIsInvalid = (new Date(start_date).getTime() > new Date(expiry_date).getTime())    
    $('#start_date').after('<label for="start_date" generated="true" class="error">Expiry Date goes before the Start Date!</label>')  if startDateIsInvalid
   

  render: ->
    @$el.html(@template())
    @

  selectItem: ->
    itm = @items.itemStore
    itmName = itm["item_name"]
    itmPrice = Number(itm["price"])
    $(@el).find('#item_name').text(itmName)
    $(@el).find('#price').text(itmPrice)
    $(@el).find('#quantity').val(1)  
    
  selectEditItem: ->
    itm = @items.itemStore
    itmName = itm["item_name"]
    itmPrice = Number(itm["price"])
    $('#editModal #item_name').text(itmName)
    $('#editModal #price').text(itmPrice)
    $('#editModal #quantity').val(1)

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
    @order_items_collection.add order_item
    tmpItms = @items.tempAdd(order_item)#temporary adding model
    $(@el).find('#total_price').text(tmpItms.price)
    $(@el).find('#total_num_of_items').text(tmpItms.totalNum)
    view = new Shop.Views.OrderItemsItem(model: order_item, collection: @items)
    @$('#items_table tbody').append(view.render().el)
          
        
  editItem: (e) ->
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
    _.each @order_items_collection.models, (model) =>
      if @items.cid == model.cid
        @items.totalPrice -= Number(model.attributes.price_per_line)
        model.set(itmQ)
        @items.totalPrice += Number(model.attributes.price_per_line)
    $(@el).find('#total_price').text(@items.totalPrice)
    $(@el).find('#total_num_of_items').text(@order_items_collection.models.length) 


  saveOrder: (e) ->    
    e.preventDefault()  
    @validateForm()  
    if @items.itemsStore.length > 0                 #here need your validation like this
      $('#new_order')[0].reset()                    #and if it's allright 
      $(@el).find('#newOrder').removeAttr("disabled")
      $(@el).find('#save').attr("disabled", true)
      attributes = 
      order_number:       $(@el).find('#order_number').val()
      status:             $(@el).find('#status').text()      
      totalPrice:        $(@el).find('#totalPrice').text()      
      total_num_of_items: $(@el).find('#total_num_of_items').text()
      date_of_ordering:   $(@el).find('#date_of_ordering').text()
    @collection.create attributes


  createNewOrder: (e) ->   
    e.preventDefault()
    attributes = 
      order_number:       $(@el).find('#order_number').val()
      status:             $(@el).find('#status').text()      
      totalPrice:        $(@el).find('#totalPrice').text()      
      total_num_of_items: $(@el).find('#total_num_of_items').text()
      date_of_ordering:   $(@el).find('#date_of_ordering').text()
    @collection.create attributes
    lenAt = @collection.length-1
    order = @collection.get(@collection.models[lenAt])
    order.save()
    console.log @collection                       #strange canot find id but it exists
    console.log order
    console.log order.cid
    @order_items_collection.order_id = {order_id: order.id} #set order_items id
    console.log @order_items_collection.order_id
    _.each @order_items_collection.models, (model) -> 
      model.save() if model.isNew()             #and save model in order_items
    $(@el).find('#newOrder').attr("disabled", true)
    $(@el).find('#save').removeAttr("disabled")
    Backbone.history.navigate("/orders", true)
      
  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true)
class Shop.Views.OrdersNew extends Backbone.View

  el: '#container'

  template: JST['orders/new']

  events:
    'submit #new_order'   : 'createOrder'
    'click #order'        : 'setOrderStatus'
    'click #cancel'       : 'returnOnMain'
    'click .item_line'    : 'selectItem'
    'click #addItem'      : 'addItem' 
      
  initialize: ->    
    @render()    
    @itemsLoad()    
    @setInitValues()
    @setMerchandiser()     
  
  itemsLoad: ->    
    @items = new Shop.Collections.Items()
    @items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          view = new Shop.Views.ItemsItem (model: model, collection: @items)                 
          $('#items tbody').append view.render().el     
    
  render: ->
    @$el.html(@template())    
    @initFormValidation()      
    @

  getTotal: ->
    total_price = 0
    $(".price").each ->
      total_price += parseFloat(@innerHTML)
    $(@el).find('#total_price').text(total_price)

    total_num_of_items = 0
    $(".quantity").each ->
      total_num_of_items += parseFloat(@innerHTML)
    $(@el).find('#total_num_of_items').text(total_num_of_items)  

  setInitValues: () ->   
    $.getJSON "/api/orderings.json", (data) ->
      num = ((_.last(data.models)).id + 1).toString() 
      console.log num     
      num = "0" + num while num.length < 6      
      $("#order_number").val(num)  

    d = new Date()    
    d = d.getFullYear() + "-" + Number(d.getUTCMonth()+1) + '-' + d.getUTCDate() 
    $(@el).find("#date_of_ordering").text(d)
    $(@el).find("#expiry_date").val(d)
    
    $(@el).find('#status').text("Created")
    $(@el).find('#order').attr("disabled", true)          

  setMerchandiser: () ->   
    $.getJSON "/api/users.json", (data) ->
      list = _.where(data.models, {role:"Merchandiser"}) 
      _.each list, (m) ->
        merch = m.login_name
        merchId = m.id
        html = '<option value='+ '"' + merch + '">' + merch + '</option>'        
        console.log html
        $('#assignee').append(html) 

  initFormValidation: -> 
    jQuery.validator.addMethod "checkPrefDeliveryDate", ((value, element) ->
      pref_delivery_date = $(@el).find("#pref_delivery_date").val()
      date_of_ordering = $(@el).find("#date_of_ordering").text()            
      new Date(pref_delivery_date).getTime() > new Date(date_of_ordering).getTime()
    ), "Preferable Delivery Date goes before the Date of Ordering!"

    jQuery.validator.addMethod "checkExpiryDate", ((value, element) ->
      expiry_date = $(@el).find("#expiry_date").val()
      start_date = $(@el).find("#start_date").val()
      new Date(start_date).getTime() < new Date(expiry_date).getTime()
    ), "Expiry Date goes before the Start Date!"

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
       # pref_delivery_date:
       #   checkPrefDeliveryDate:true
        start_date:
          required: true
        expiry_date:
          required: true
        #  checkExpiryDate:true
          
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
        pref_delivery_date:
          checkPrefDeliveryDate: "Preferable Delivery Date goes before the Date of Ordering!"
        start_date:
          required: "Start Date cannot be blank!"  
        expiry_date:
          required: "Expiry Date cannot be blank!"
          checkExpiryDate: "Expiry Date goes before the Start Date!"     

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
      when "Item"    then itm["price_per_line"] = itm["price"]*itm["quantity"]
      when "Box"     then itm["price_per_line"] = itm["price"]*itm["quantity"]*5
      when "Package" then itm["price_per_line"] = itm["price"]*itm["quantity"]*10
    itmQ =
      #order_id: Number(@order_id)
      #order_id: @model.get('id')
      order_id: 0
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
    @getTotal()       

  createOrder: (event) ->    
    order_items = @model.order_items    
    collection_of_orders = @collection

    event.preventDefault()        
    attributes = 
      user_id:            Number(curUser.id)   
      order_number:       $(@el).find('#order_number').val()
      status:             $(@el).find('#status').text()     
      date_of_ordering:   $(@el).find('#date_of_ordering').text()
      pref_delivery_date: $(@el).find('#pref_delivery_date').val()    
      role:               $(@el).find('#assignee').val()
      credit_card_type:   $(@el).find('#credit_card_type').val()
      credit_card_number: $(@el).find('#credit_card_number').val()
      cvv2:               $(@el).find('#cvv2').val()
      expiry_date:        $(@el).find('#expiry_date').val()
      start_date:         $(@el).find('#start_date').val()
      issue_number:       $(@el).find('#issue_number').val()
            
    @model.save attributes,   
      success: (model, response) ->    
        #$('#new_order')[0].reset()
        order_id = Number(response.id)        
        _.each order_items.models, (oder_item) -> 
          console.log oder_item                   
          oder_item.set({order_id:order_id})
          oder_item.save
            wait: true      
            succes: ->
            error: @handleError             
        collection_of_orders.add @model
        $('#order').removeAttr("disabled", true)          
        #Backbone.history.navigate("/orders", true)            
      error: @handleError        
     

  handleError: (order, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  setOrderStatus: (event) ->    
    event.preventDefault()    
    attributes = 
      status: "Pending"     
    
    @model.save attributes,
      succes: ->
        #$(@el).find('#order').attr("disabled", true)
        #$(@el).find('#save').removeAttr("disabled")
        Backbone.history.navigate("/orders", true)      

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true)
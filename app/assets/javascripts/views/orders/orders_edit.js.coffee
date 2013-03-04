class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:    
    'submit #edit_order'                : 'editOrder'
    'click #order'                      : 'setOrderStatus'    
    'click #cancel'                     : 'returnOnMain'

    'click .popup'                      : 'openPopup'
    'click #popupAddItem .item_line'    : 'selectItem'
    'click #popupAddItem #addItem'      : 'addItem'
    'click #popupAddItem #editItem'     : 'editItem' 
    'click #popupAddItem #remove'       : 'clearFields'  
    'click #popupAddItem #cancelEdit'   : 'cancelEdit' 
   
  initialize: ->
    #@model.on('change', @render, @)      
    @render()
    @orderItemsLoad()   
    @itemsLoad()
    @setMerchandiser()
        
  render: ->    
    $(@el).html(@template(order: @model))
    @initFormValidation()          
    @

  openPopup: (e) ->
    e.preventDefault()
    $(@el).find('#addItem').show()
    $(@el).find('#editItem').hide()

  orderItemsLoad: ->  
    @model.order_items = new Shop.Collections.OrderItems({order_id: @model.get('id')})                              
    orderEditView = @
    orderEditModel = @model
    @model.order_items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          orderView = new Shop.Views.OrderItemsItem(model: model, collection:collection)
          orderView.parentView = orderEditView          
          orderView.parent = orderEditModel
          @$('#items_table tbody').append(orderView.render().el)          
    console.log @model.order_items    
    @render()    

  itemsLoad: ->    
    order = @model
    @model.items = new Shop.Collections.Items()    
    items = @model.items
    @model.items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          html = '<tr class = "item_line" data-id=' + model.get('id') + '><td>' + model.get('item_name') + '</td><td>' + model.get('item_description') + '</td></tr>'     
          $('#items tbody').append(html)

        $("#items").dataTable
          bPaginate: false
          bLengthChange: false
          bFilter: true
          bSort: false
          bInfo: false
          bAutoWidth: false
          aoColumns: [null, null]  

  setMerchandiser: () ->   
    assignee = @model.get('role')
    console.log assignee
    $.getJSON "/api/users.json", (data) ->
      list = _.where(data.models, {role:"Merchandiser"}) 
      _.each list, (m) ->
        merch = m.login_name
        merchId = m.id
        selectedOption = (if (assignee is merch) then " selected" else "")
        html = '<option value='+ '"' + merch + '"' + selectedOption + '>' + merch + '</option>'                
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

    $(@el).find('form#edit_order').validate
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


  getTotal: (quantity, price_per_line)  ->
    total_price = Number($(@el).find('#total_price').text())
    total_price = total_price + price_per_line
    $(@el).find('#total_price').text(total_price)
    
    number_of_items = Number($(@el).find('#total_num_of_items').text())
    number_of_items = number_of_items + quantity
    $(@el).find('#total_num_of_items').text(number_of_items)

  clearFields: ->
    $(@el).find('#item_name').text("")
    $(@el).find('#price').text("")
    $(@el).find('#quantity').val(1)  

  selectItem: (e) ->
    item_id = $(e.target).parent().data('id')
    @itm = @model.items.get(item_id)
    itmName = @itm.get("item_name")
    itmPrice = @itm.get("price")
    $(@el).find('#item_name').text(itmName)
    $(@el).find('#price').text(itmPrice)
    $(@el).find('#quantity').val(1)
 
  addItem: (e) =>
    e.preventDefault()

    price     = Number($(@el).find('#price').text())
    dimension = $(@el).find('#dimension :selected').val()
    quantity  = Number($(@el).find('#quantity').val())
    
    price_per_line = price*quantity
    
    switch dimension      
      when "Box"     then price_per_line *= 5
      when "Package" then price_per_line *= 10
    itmQ =
      order_id         : @model.get('id')
      item_id          : @itm.get("id") 
      quantity         : quantity
      dimension        : dimension
      price_per_line   : price_per_line
      item_name        : @itm.get("item_name")
      item_description : @itm.get("item_description")
      price            : price

    order_item = new Shop.Models.OrderItem(itmQ)    
    @model.order_items.add(order_item)    
    view = new Shop.Views.OrderItemsItem(model: order_item, collection: @model.order_items)
    view.parentView = @    
    view.parent = @model
    @$('#items_table tbody').append(view.render().el)  
    @getTotal(quantity,price_per_line)       

  editItem: (e) =>
    e.preventDefault()

    price     = Number($(@el).find('#price').text())
    dimension = $(@el).find('#dimension :selected').val()
    quantity  = Number($(@el).find('#quantity').val())
    
    price_per_line = price*quantity
    
    switch dimension      
      when "Box"     then price_per_line *= 5
      when "Package" then price_per_line *= 10
    itmQ =
      order_id         : @model.get('id')
      item_id          : @itm.get("id") 
      quantity         : quantity
      dimension        : dimension
      price_per_line   : price_per_line
      item_name        : @itm.get("item_name")
      item_description : @itm.get("item_description")
      price            : price

    order_item = new Shop.Models.OrderItem(itmQ)  
    
    @model.order_items.remove(@model.editItem)  
    @model.order_items.removedOrderItems.push(@model.editItem)   

    @model.order_items.add(order_item)    
    
    view = new Shop.Views.OrderItemsItem(model: order_item, collection: @model.order_items)
    view.parentView = @    
    view.parent = @model
    @$('#items_table tbody').append(view.render().el)  
    
    deleted_price = - Number($(@el).find('#deletedItem .price').html())
    deleted_quantity = - Number($(@el).find('#deletedItem .quantity').html())
    @getTotal(deleted_quantity,deleted_price)
    $(@el).find('#deletedItem').remove() 

    @getTotal(quantity,price_per_line)   
    
  cancelEdit: ->    
    $(@el).find('#deletedItem').removeAttr("id")
  
  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true) 

  editOrder: (event) ->      
    event.preventDefault()
    if @model.order_items.length is 0   
      alert "Please select items and add them to the order."
    else    
      attributes =               
        pref_delivery_date : $(@el).find('#pref_delivery_date').val()
        role               : $(@el).find('#assignee').val() 
        total_price        : Number($(@el).find('#total_price').text())
        total_num_of_items : Number($(@el).find('#total_num_of_items').text())       
        credit_card_type   : $(@el).find('#credit_card_type').val()
        credit_card_number : $(@el).find('#credit_card_number').val()
        cvv2               : $(@el).find('#cvv2').val()
        expiry_date        : $(@el).find('#expiry_date').val()
        start_date         : $(@el).find('#start_date').val()
        issue_number       : $(@el).find('#issue_number').val()     

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

  setOrderStatus: (event) ->    
    event.preventDefault()            
    @model.save 
    window.location.href = "/orders"

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages             
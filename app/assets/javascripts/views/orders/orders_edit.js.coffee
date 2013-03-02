class Shop.Views.OrdersEdit extends Backbone.View

  el: '#container'

  template: JST['orders/show'] 

  events:    
    'submit #edit_order'        : 'editOrder'
    'click #order'              : 'setOrderStatus'    
    'click #cancel'             : 'returnOnMain'

    'click #mAdd .item_line'    : 'selectAddItem'
    'click #mAdd #addItem'      : 'addItem'
    'click #mAdd #remove'       : 'clearFields'  

    'click #mEdit .item_line'   : 'selectEditItem'
    'click #mEdit #editItem'    : 'editItem' 
    'click #mEdit #cancelEdit'  : 'cancelEdit' 
    'click #mEdit #remove'      : 'clearFields'

   
  initialize: ->
    #@model.on('change', @render, @)      
    @render()
    @orderItemsLoad()   
    @itemsLoad()
    @setMerchandiser()
        
  render: ->    
    $(@el).html(@template(order: @model))    
    @

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

  selectAddItem: (e) ->
    item_id = $(e.target).parent().data('id')
    @itm = @model.items.get(item_id)
    itmName = @itm.get("item_name")
    itmPrice = @itm.get("price")
    $(@el).find('#mAdd #item_name').text(itmName)
    $(@el).find('#mAdd #price').text(itmPrice)
    $(@el).find('#mAdd #quantity').val(1)

  selectEditItem: (e) ->
    item_id = $(e.target).parent().data('id')
    @itm = @model.items.get(item_id)
    itmName = @itm.get("item_name")
    itmPrice = @itm.get("price")
    $(@el).find('#mEdit #item_name').text(itmName)
    $(@el).find('#mEdit #price').text(itmPrice)
    $(@el).find('#mEdit #quantity').val(1)          

  addItem: (e) =>
    e.preventDefault()

    price     = Number($(@el).find('#mAdd #price').text())
    dimension = $(@el).find('#mAdd #dimension :selected').val()
    quantity  = Number($(@el).find('#mAdd #quantity').val())
    
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

    price     = Number($(@el).find('#mEdit #price').text())
    dimension = $(@el).find('#mEdit #dimension :selected').val()
    quantity  = Number($(@el).find('#mEdit #quantity').val())
    
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
    $(@el).find('#deletedItem').remove() 
    @getTotal(quantity,price_per_line)   
    
  cancelEdit: ->    
    $(@el).find('#deletedItem').removeAttr("id")
  
  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("/orders", true) 

  editOrder: (event) ->      
    event.preventDefault()
    attributes =       
      delivery_date      :  $(@el).find('#delivery_date').text()
      pref_delivery_date :  $(@el).find('#pref_delivery_date').val()
      role               :  $(@el).find('#assignee').val() 
      total_price        :  Number($(@el).find('#total_price').text())
      total_num_of_items :  Number($(@el).find('#total_num_of_items').text())
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
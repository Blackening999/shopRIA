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
    @model.order_items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          orderView = new Shop.Views.OrderItemsItem(model: model, collection:collection)
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

    price     = $(@el).find('#price').text()
    dimension = $(@el).find('#dimension :selected').val()
    quantity  = $(@el).find('#quantity').val()  
    
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
      pref_delivery_date: $(@el).find('#pref_delivery_date').val()
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
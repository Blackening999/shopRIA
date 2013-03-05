class Shop.Views.ItemsNew extends Backbone.View

  el: '#supervisor'

  template: JST['items/new']

  events:
    "submit #new_item": "createItem"
    'click #cancel'   : 'returnOnMain'  
    'click #refresh'  : 'refreshFields'   

  initialize: ->
    @collection.on('add', @render, @)
    @render()
    
  render: ->
    @$el.html(@template())   
    @initFormValidation()
    @

  initFormValidation: ->
    @$('form').validate
      rules:
        item_name: 
          required: true
        item_description: 
          required: true             
        price:
          required: true
      messages:
        item_name: 
          required: "Item name cannot be blank!"         
        item_description: 
          required: "Item description cannot be blank!"
        price: 
          required: "Price cannot be blank!"  

  createItem: (event) ->
    event.preventDefault() 
    collection_of_items = @collection

    attributes = 
      item_name: $(@el).find('#item_name').val()
      item_description: $(@el).find('#item_description').val()
      price: $(@el).find('#price').val()      
      
    @model.save attributes,
      success: (model, response) ->    
        collection_of_items.add model        
     
    #window.location.href = "/items"      

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("", true)

  refreshFields: ->
    $(@el).find('#item_name').val('')
    $(@el).find('#item_description').val('')
    $(@el).find('#price').val('')
   

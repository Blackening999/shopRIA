class Shop.Views.ItemsEdit extends Backbone.View
  
  template: JST['items/edit']
  
  el: '#supervisor'

  events:
    'submit #edit_item' : 'editItem'
    'click #cancel'     : 'returnOnMain' 
    'click #refresh'    : 'refreshFields'

  initialize: ->
    @model.on('change', @render, @)
    @render()

  render: ->
   $(@el).html(@template(item: @model))   
   @

  editItem: (event) ->
    event.preventDefault()
    attributes = 
      item_name: $(@el).find('#item_name').val()
      item_description: $(@el).find('#item_description').val()
      price: $(@el).find('#price').val() 
    @model.save attributes,
      wait: true      
      error: @handleError    
    #window.location.href = "/items"   

  handleError: (item, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages    

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      window.location.href = "/items"   

  refreshFields: ->
    $(@el).find('#item_name').val(@model.get('item_name'))
    $(@el).find('#item_description').val(@model.get('item_description'))
    $(@el).find('#price').val(@model.get('price'))
   
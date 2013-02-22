class Shop.Views.ItemsNew extends Backbone.View

  el: '#supervisor'

  template: JST['items/new']

  events:
    "submit #new_item": "createItem"
    #'click #cancel'   : 'returnOnMain'  
    #'click #refresh'  : 'refreshFields'
    #'focusout input[name=login_name]': 'checkLogin'  

  initialize: ->
    @collection.on('add', @render, @)
    @render()
    
  render: ->
    @$el.html(@template())
    @

  createItem: (event) ->
    event.preventDefault()
    attributes = 
      item_name: $(@el).find('#item_name').val()
      item_description: $(@el).find('#item_description').val()
      price: $(@el).find('#price').val()      
      
    @collection.create attributes,
      wait: true
      success: -> 
        $('#new_item')[0].reset()
        window.history.back()
      error: @handleError

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  # returnOnMain: ->
  #   if confirm 'Are you sure you want to cancel operation. All data will be lost?'
  #     Backbone.history.navigate("", true)

  # refreshFields: ->
  #   $(@el).find('#new_login_name').val('')
  #   $(@el).find('#new_first_name').val('')
  #   $(@el).find('#new_lastName').val('')
  #   $(@el).find('#new_password').val('')
  #   $(@el).find('#new_confirmPassword').val('')
  #   $(@el).find('#new_email').val('')
  #   $(@el).find('#region :selected').empty()
  #   $(@el).find('input:radio:checked').empty()

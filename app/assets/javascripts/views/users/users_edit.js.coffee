class Shop.Views.UsersEdit extends Backbone.View
  
  template: JST['users/edit']
  
  el: '#app'

  events:
    'submit #edit_user' : 'editUser'
    'click #cancel'     : 'returnOnMain' 
    'click #refresh'    : 'refreshFields'

  initialize: ->
    @model.on('change', @render, @)
    @render()

  render: ->
   $(@el).html(@template(user: @model))

   jQuery.validator.addMethod "noSpace", ((value, element) ->
     value.indexOf(" ")<0
   ), "Field cannot contain spaces"
   
   jQuery.validator.addMethod "noNumbers", ((value, element) ->
     not /\d/.test(value)
   ), "cannot contain numbers"  

   @$('form').validate
     rules:
       first_name: 
         required: true
         maxlength: 50
         noNumbers: true

       last_name: 
         required: true
         maxlength: 50
         noNumbers: true

       email:
         required: true
         email: true

     messages:
       first_name: 
         required: "First name cannot be blank!"
         maxlength: "First name is too long"
         noNumbers: "First name cannot contain numbers"
       last_name: 
         required: "Last name cannot be blank!"
         maxlength: "Last name is too long"
         noNumbers: "Last name cannot contain numbers"
   @

  editUser: (event) ->
    event.preventDefault()
    attributes = 
      first_name: @$el.find('#new_first_name').val()
      last_name: @$el.find('#new_lastName').val()
      email: @$el.find('#new_email').val()
      region: @$el.find('#region :selected').val()
      role: @$el.find('input:radio:checked').val()
    @model.save attributes,
      wait: true
      error: @handleError
    

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages    

  returnOnMain: ->
    if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      Backbone.history.navigate("", true)

  refreshFields: ->
    $(@el).find('#new_first_name').val(@model.attributes.first_name)
    $(@el).find('#new_lastName').val(@model.attributes.last_name)
    $(@el).find('#new_email').val(@model.attributes.email)
    $(@el).find('#region :selected').val(@model.attributes.region)
    $(@el).find('input:radio:checked').val(@model.attributes.role)
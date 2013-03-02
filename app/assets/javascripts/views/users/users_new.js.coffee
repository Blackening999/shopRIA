class Shop.Views.UsersNew extends Backbone.View

  el: '#app'

  template: JST['users/new']

  events:
    "submit #new_user": "createUser"
    'click #cancel'   : 'returnOnMain'  
    'click #refresh'  : 'refreshFields'
    'focusout input[name=login_name]': 'checkLogin'  

  initialize: ->
    @collection.on('add', @render, @)
    @render()
  
  checkLogin: ->
    $.getJSON "/api/users.json", (data) ->
      $.each data, (index, user) ->
        if user.login_name is $("input[name=login_name]").val()
          $('#new_login_name').after('<label for="new_login_name" generated="true" class="error">Login name already exists</label>')
          true

  render: ->
    @$el.html(@template())
   
    jQuery.validator.addMethod "noSpace", ((value, element) ->
      value.indexOf(" ")<0
    ), "Field cannot contain spaces"
   
    jQuery.validator.addMethod "noNumbers", ((value, element) ->
      not /\d/.test(value)
    ), "cannot contain numbers"  

    jQuery.validator.addMethod "passwordComplexity", ((value, element) ->
      /[!@#$%^&*()_+|~\-=\\/'{}\[\]:"`<>?,.]/.test(value) and /[A-Z]/.test(value) and /[a-z]/.test(value) and /\d/.test(value)
    ), "The value provided for the password does not meet required complexity"

   
    @$('form').validate
      rules:
        login_name: 
          required: true
          maxlength: 20
          noSpace: true
          
        first_name: 
          required: true
          maxlength: 50
          noNumbers: true

        last_name: 
          required: true
          maxlength: 50
          noNumbers: true

        password:
          required: true
          minlength: 4
          maxlength: 10
          noSpace: true
          passwordComplexity: true

        confirm_password:
          required: true
          equalTo: "#new_password"

        email:
          required: true
          email: true

      messages:
        login_name: 
          required: "Login name cannot be blank!"
          maxlength: "Login name is too long"
          noSpace: "Login name cannot contain spaces"
        first_name: 
          required: "First name cannot be blank!"
          maxlength: "First name is too long"
          noNumbers: "First name cannot contain numbers"
        last_name: 
          required: "Last name cannot be blank!"
          maxlength: "Last name is too long"
          noNumbers: "Last name cannot contain numbers"
        password:
          required: "Password cannot be blank!"
          minlength: "Password field cannot be shorter than 4 characters"
          maxlength: "Password field cannot be longer than 10 characters"
          noSpace: "Password cannot contain spaces"
        confirm_password:
          required: "Confirm password cannot be blank!"
          equalTo: "Confirm password is not equal to Password"       
    @

  createUser: (event) ->
    event.preventDefault()
    attributes = 
      login_name: $(@el).find('#new_login_name').val()
      first_name: $(@el).find('#new_first_name').val()
      last_name: $(@el).find('#new_lastName').val()
      password: $(@el).find('#new_password').val()
      password_confirmation: $(@el).find('#new_confirmPassword').val()
      email: $(@el).find('#new_email').val()
      region: $(@el).find('#region :selected').val()
      role: $(@el).find('input:radio:checked').val()
      
    @collection.create attributes,
      wait: true
      success: -> 
        $('#new_user')[0].reset()
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
    $(@el).find('#new_login_name').val('')
    $(@el).find('#new_first_name').val('')
    $(@el).find('#new_lastName').val('')
    $(@el).find('#new_password').val('')
    $(@el).find('#new_confirmPassword').val('')
    $(@el).find('#new_email').val('')
    $(@el).find('#region :selected').empty()
    $(@el).find('input:radio:checked').empty()

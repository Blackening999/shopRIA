class Shop.Views.UsersDuplicate extends Backbone.View

  el: '#app'

  template: JST['users/duplicate']

  events:
    'submit #duplicate_user': 'duplicateUser'  
    'click #cancel': 'returnOnMain'   
    'click #refresh': 'refreshFields'
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
   $(@el).html(@template())
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

       password:
         required: true
         minlength: 4
         maxlength: 10
         noSpace: true
         passwordComplexity: true

       password_confirmation:
         required: true
         equalTo: "#new_password"

     messages:
       login_name: 
         required: "Login name cannot be blank!"
         maxlength: "Login name is too long"
         noSpace: "Login name cannot contain spaces"
       password:
         required: "Password cannot be blank!"
         minlength: "Password field cannot be shorter than 4 characters"
         maxlength: "Password field cannot be longer than 10 characters"
         noSpace: "Password cannot contain spaces"
       password_confirmation:
         required: "Confirm password cannot be blank!"
         equalTo: "Confirm password is not equal to Password"       
   @

  duplicateUser: (event) ->
    event.preventDefault()
    attr = @attributes.attributes
    attr.login_name = $(@el).find('#new_login_name').val()
    attr.password = $(@el).find('#new_password').val()
    attr.password_confirmation = $(@el).find('#new_confirmPassword').val()
    @collection.create attr,
      wait: true
      success: -> 
        $('#duplicate_user')[0].reset()
      error: @handleError

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages

  returnOnMain: ->
    Backbone.history.navigate("", true) if confirm 'Are you sure you want to cancel operation. All data will be lost?'
      

  refreshFields: (e) ->
    e.preventDefault()
    $(@el).find('#new_login_name').val(@attributes.attributes.login_name)
    $(@el).find('#new_password').val(@attributes.attributes.password)
    $(@el).find('#new_confirmPassword').val(@attributes.attributes.password_confirmation)
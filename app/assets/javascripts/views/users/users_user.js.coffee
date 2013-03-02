class Shop.Views.UsersUser extends Backbone.View
  
  template: JST['users/user']
  tagName: 'tr'

  events:
    'dblclick': 'showUser'
    'click #edit': 'goToEdit'
    'click #destroy': 'destroy'
    'click #duplicate': 'goToDuplicate'
   
  initialize: ->
    @model.on('change', @render, @) #no need here
    
  render: ->
    $(@el).html(@template(user: @model))
    @

  showUser: ->
    Backbone.history.navigate("users/#{@model.get('id')}", true)

  goToEdit: ->
    Backbone.history.navigate("#{@model.get('id')}/edit", true)
  
  goToDuplicate: -> 
    Backbone.history.navigate("#{@model.get('id')}/duplicate", true) 

  destroy: ->
    @model['url'] = "/api/users/#{@model.get('id')}"
    @model.destroy() if confirm 'The user will be deleted from the List of Users. Are you sure you want to proceed?'   
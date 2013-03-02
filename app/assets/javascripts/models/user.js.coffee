class Shop.Models.User extends Backbone.Model

  url: ->
    if @id?
      "/api/users/#{@id}"
    else
      "/api/users"

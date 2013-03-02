class Shop.Models.Item extends Backbone.Model
  
  url: ->
    if @id?
      "/api/items/#{@id}"
    else
      "/api/items" 
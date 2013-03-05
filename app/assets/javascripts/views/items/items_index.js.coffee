class Shop.Views.ItemsIndex extends Backbone.View

  template: JST['items/index']

  events:
    'click .backbone'   : 'navigateLink' 

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)    
    
  render: ->
    $(@el).html(@template(items: @collection))
    @collection.each(@appendItem)
    @

  appendItem: (item) =>
    view = new Shop.Views.ItemsLine(model: item)
    @$('#table_items tbody').append(view.render().el)  
  
  navigateLink: (event) ->
    event.preventDefault()
    Backbone.history.navigate(event.target.attributes["href"].value, true)     
    false  
  


class Shop.Views.ItemsItem extends Backbone.View

  template: JST['items/item']
  tagName: 'tr'
  className: 'item_line'

  events:
    'click': 'selectItem'
  
  render: ->
    $(@el).html(@template(item: @model))
    @
   
  selectItem: ->
    @model.collection.itemStore = @model.attributes    

class Shop.Views.OrderItemsItem extends Backbone.View

  template: JST['order_items/item']
  tagName: 'tr'
  className: 'order_item_line'

  events:
    'click #edit'    : 'goToEdit'
    'click #destroy' : 'destroy' 
   
  render: ->
    $(@el).html(@template(item: @model, pid:@parent.id))
    @

  goToEdit: ->   
    @parent.editItem = @model
    $(@el).attr('id', 'deletedItem')
    @parent.editItemEl = @el    

    if @parent.id?     
      console.log "id=" + @model.id
    else
      console.log "no id" 
   
  getTotal: ->
    total_price = $(@parentView.el).find('#total_price').text()
    total_price = total_price - @model.get('price_per_line') 
    $(@parentView.el).find('#total_price').text(total_price)
    
    number_of_items = $(@parentView.el).find('#total_num_of_items').text()
    number_of_items = number_of_items - @model.get('quantity') 
    $(@parentView.el).find('#total_num_of_items').text(number_of_items)

  destroy: ->    
    @getTotal()
    @model.collection.removedOrderItems.push @model 
    @model.collection.remove(@model)
    $(@el).remove()
    console.log @collection
    
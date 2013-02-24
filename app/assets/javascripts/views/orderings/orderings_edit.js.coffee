class Shop.Views.OrderingsEdit extends Backbone.View

  el: '#merchandiser'

  template: JST['orderings/edit'] 

  events:
    'submit #edit_ordering' : 'editOrdering'
     
  initialize: ->
    @model.on('change', @render, @)      
    @render()    
    @itemsLoad()
       
  render: ->    
    $(@el).html(@template(order: @model))        
    @

  itemsLoad: ->
    @model.order_items.fetch
      success: (collection) ->
        _.each collection.models, (model) ->
          orderView = new Shop.Views.OrderItemsItem(model: model)
          @$('#items_table tbody').append(orderView.render().el)
    @render()          
        

  editOrdering: (event) ->  
    event.preventDefault()
    attributes = 
      status: @$el.find('input:radio:checked').val()   
      delivery_date: $(@el).find('#delivery_date').val() 
    @model.save attributes,
      wait: true      
      error: @handleError    

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages         
   
  
class Shop.Views.OrderingsEdit extends Backbone.View

  el: '#merchandiser'

  template: JST['orderings/edit'] 

  events:
    'submit #edit_ordering' : 'editOrdering'
    'click #checkDelivered' : 'setDeliveryDate' 
     
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
          orderView = new Shop.Views.OrderingsItemsItem(model: model)
          @$('#items_table tbody').append(orderView.render().el)
        
        $("#items_table").dataTable
          "sPaginationType": "full_numbers"    
    
    @render()    

  setDeliveryDate: ->
    delivered = $(@el).find('#checkDelivered').prop("checked")
    if delivered
      today = new Date()
      dd = today.getDate()
      mm = today.getMonth()+1
      yyyy = today.getFullYear()
      dd = "0" + dd if dd<10
      mm = "0" + mm if mm<10    
      today =  yyyy + '-' + mm + '-' + dd
      $(@el).find('#delivery_date').val(today)
        
  editOrdering: (event) ->  
    event.preventDefault()
    ordered   = $(@el).find('#checkOrdered').prop("checked")
    delivered = $(@el).find('#checkDelivered').prop("checked")

    status = "Ordered" if ordered 
    status = "Delivered" if delivered 

    attributes = 
      status        : status   
      delivery_date : $(@el).find('#delivery_date').val() 
    @model.save attributes,
      succes: ->
        console.log "saved"
    window.location.href = "/orderings"      

  handleError: (user, response) ->
    if response.status == 422
      errors = $.parseJSON(response.responseText).errors
      for attribute, messages of errors
        alert "#{attribute} #{message}" for message in messages         
   
  
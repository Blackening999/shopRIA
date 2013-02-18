class Shop.Views.OrdersIndex extends Backbone.View

  template: JST['orders/index']

  events:
    'change #filter' : 'fillFilterOptions'
    'click .backbone': 'navigateLink' 
    'click th'  : 'sortTable'

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)

  render: ->
    $(@el).html(@template(orders: @collection, pageInfo: @collection.pageInfo() ))
    @collection.each(@appendOrder)
    @

  navigateLink: (event) ->
    event.preventDefault()
    Backbone.history.navigate(event.target.attributes["href"].value, true)     
    false

  sortTable: (event) ->
    event.preventDefault()
    if @collection.pageInfo().orderBy.match /[a-zA-Z]+\s*desc/i
      Backbone.history.navigate(event.target.attributes["href"].value, true) 
      #@collection.fetch()
      false
    if @collection.pageInfo().orderBy.match /[a-zA-Z]+\s*asc/i
      Backbone.history.navigate(event.target.attributes["id"].value, true)
      #@collection.fetch()
      false
    false

  appendOrder: (order) =>
    view = new Shop.Views.OrdersOrder(model: order)
    @$('tbody').append(view.render().el)  

  fillFilterOptions: ->
    $("#filter_options").children().remove()
    cur_filter = (@$("#filter option:selected").val())    
    status = ["", "Ordered", "Pending", "Delivered"]
    role = ["", "Merchandiser", "Administrator", "Supervisor"]    
    if cur_filter is "Role"
      i = 0      
      while i < role.length
        $("#filter_options").append $("<option></option>").attr("value", role[i]).text(role[i])
        i++  
    if cur_filter is "Status"
      i = 0      
      while i < status.length
        $("#filter_options").append $("<option></option>").attr("value", status[i]).text(status[i])
        i++ 

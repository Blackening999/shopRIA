class Shop.Views.OrdersIndex extends Backbone.View

  template: JST['orders/index']

  events:
    'change #filter_by' : 'fillFilterOptions'
    'click .backbone'   : 'navigateLink' 
    'click th'          : 'sortTable'
    'click #search'     : 'setFilter'

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)
    #@trigger 'click #search'
    console.log @collection

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

  setFilter: (e) ->
    e.preventDefault()
    newFilter = $(@el).find('#filter_by :selected').val()
    newFilterOpt = $(@el).find('#filter_options :selected').val()
    newSearch = $(@el).find('#search_orders :selected').val()
    newRequest = $(@el).find('#filterText').val()
    @collection.filterTable(newFilter, newFilterOpt, newSearch, newRequest)
    @render

  fillFilterOptions: ->
    $("#filter_options").children().remove()
    cur_filter = (@$("#filter_by option:selected").val())    
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

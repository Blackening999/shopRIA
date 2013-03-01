class Shop.Collections.OrderItems extends Backbone.Collection
 
  baseUrl: '/api/orders' #base
  model: Shop.Models.OrderItem  

    
  initialize: (order_id) ->
    @removedOrderItems = new Array()  
   
    #@order_id = order_id
    if order_id?
      @baseUrl += '/' + order_id.order_id + '/order_items' #base

  parse: (resp) =>
    @setPageInfo(resp)
    resp["models"]


  setPageInfo: (options) =>
    @page = options['page']
    @pp = options['pp']  
    @num_pages = options['num_pages']
    @total_count = options['total_count']
    @orderBy = "id asc" 

  pageInfo: =>
    info =
      page: @page
      pp: @pp
      num_pages: @num_pages
      total_count: @total_count
      next: false
      orderBy: @orderBy
      
  setParams:(orderBy, page, pp) =>
    return unless page > 0
    [oldOrderBy, @orderBy] = [@orderBy, String(orderBy)]
    [oldPage, @page] = [@page, Number(page)]
    [oldPP, @pp] = [@pp, Number(pp)]
    @fetch() unless oldOrderBy == @orderBy && oldPage == @page && oldPP == @pp

  url: ->
    _.locationWithParams(@baseUrl)#, {orderBy: @orderBy, page: @page, pp: @pp})  
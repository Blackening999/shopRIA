class Shop.Collections.Orders extends Backbone.Collection

  baseUrl: '/api/orders'
  model: Shop.Models.Order
  
  parse: (resp) =>
    @setPageInfo(resp)
    resp["models"]


  setPageInfo: (options) =>
    @filter_by = "status"
    @filter_options = "ordered"
    @search_orders = "order_number"
    @request = ""
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
      filter_by: @filter_by
      filter_options: @filter_options
      search_orders: @search_orders
      request: @request

  setParams:(orderBy, page, pp) =>
    return unless page > 0
    [oldOrderBy, @orderBy] = [@orderBy, String(orderBy)]
    [oldPage, @page] = [@page, Number(page)]
    [oldPP, @pp] = [@pp, Number(pp)]
    @fetch() unless oldOrderBy == @orderBy && oldPage == @page && oldPP == @pp

  filterTable: (newFilter, newFilterOpt, newSearch, newRequest) =>
    @filter_by = newFilter
    @filter_options = newFilterOpt
    @search_orders = newSearch
    @request = newRequest
    @fetch()

  url: ->
    _.locationWithParams(@baseUrl, {orderBy: @orderBy, page: @page, pp: @pp, filter_by: @filter_by, filter_options: @filter_options, search_orders: @search_orders, request: @request})
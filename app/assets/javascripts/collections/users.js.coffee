class Shop.Collections.Users extends Backbone.Collection

  baseUrl: '/api/users'
  model: Shop.Models.User
  sortStore: ""
  
  initialize: (options) =>
    @init_pagination(options)

  pageInfo: =>
    info =
      numPages: @numPages
      currentPage: @currentPage
      perPage: @perPage
      prev: false
      next: false
      orderBy: @orderBy
      totalCount: @totalCount
      fields: @fields
      start_with: @start_with
      request: @request
        
  parse: (resp) =>
    @init_pagination(resp)
    resp["models"]

  init_pagination: (options) =>
    @currentPage = options['current_page']
    @perPage = options['per_page']
    @numPages = options['num_pages']
    @totalCount = options['total_count']
    @orderBy = "id asc"
   
  howManyPer: (newPerPage) =>
    @currentPage = 1
    @perPage = newPerPage
    @fetch()

  sortTableAsc: (ident) =># NEED refactor
    @orderBy = "#{ident} asc"
    @fetch()

  sortTableDesc: (ident) =># NEED refactor
    @orderBy = "#{ident} desc"
    @fetch()

  sortTableMulti: (ident) =># NEED refactor
    @orderBy = "#{ident} asc"
    if @sortStore is ""
      @sortStore = @orderBy
    else
      @sortStore += ", " + @orderBy
    @orderBy = @sortStore
    @fetch()

    
  filterTable: (newField, newStartWith, newRequest) =>
    @fields = newField
    @start_with = newStartWith
    @request = newRequest
    @fetch()
        
  nextPage: =>
    @currentPage = @currentPage + 1
    return @fetch()
 
  previousPage: =>
    @currentPage = @currentPage - 1
    return @fetch()

  gotoPage: (page) =>
    @currentPage = page
    return @fetch()

  url: =>
    @baseUrl + '?' + $.param({orderBy: @orderBy, currentPage: @currentPage, perPage: @perPage, fields: @fields, scope: @start_with, request: @request})

  duplicateUser: (userId) ->
    curAttr = @get(userId).attributes
    dupl_user = new Shop.Models.User(curAttr)
    dupl_user.id = undefined
    dupl_user.attributes["id"] = undefined
    dupl_user   
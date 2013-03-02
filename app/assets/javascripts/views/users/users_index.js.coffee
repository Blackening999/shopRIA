class Shop.Views.UsersIndex extends Backbone.View

  template: JST['users/index']
  
  events:
    'click #user_create_button': 'createUser'
    'click #backward'          : 'previous'
    'click #forward'           : 'next'
    'click #first'             : 'first'
    'click #last'              : 'last'
    'click .paging a'          : 'changeShownNum'
    'click #forSort'           : 'sortUsersAsc'
    'dblclick #forSort'        : 'sortUsersDesc'
    'click #search'            : 'setFilter'
    'click .forSort'           : 'multiSort'

  initialize: ->
    @collection.on('reset', @render, @)
    @collection.on('add', @render, @)
    @collection.on('destroy', @render, @)
    @collection.on('change', @render, @)
    @trigger 'click #search', @collection.filterTable 'login_name', 'start_with', ''

  render: ->
    $(@el).html(@template(users: @collection, pageInfo: @collection.pageInfo() ))
    @collection.each(@appendUser)
    @

  appendUser: (user) =>
    view = new Shop.Views.UsersUser(model: user)
    @$('tbody').append(view.render().el)

  createUser: ->
    Backbone.history.navigate("/new", true)

  previous: =>
    @collection.previousPage()
    return false
 
  next: =>
    @collection.nextPage()
    return false

  last: =>
    @collection.gotoPage(@collection.pageInfo().numPages)
    return false

  first: =>
    @collection.gotoPage(1)
    return false

  changeShownNum: (e) ->
    e.preventDefault()
    per = $(e.target).text().substring(5,7)
    @collection.howManyPer(per)
    @render

  sortUsersAsc: (e) -># NEED refactorr
    e.preventDefault()
    return if e.ctrlKey
    @collection.sortStore = ""
    str = $(e.target).text()
    colName = String(str.match /[a-zA-Z]+\s*\w*[^\s]/i).replace(/\s/, '_').toLowerCase()
    if colName is "user_name"
      colName = "login_name"
    @collection.sortTableAsc(colName)
    @render

  sortUsersDesc: (e) -># NEED refactor
    e.preventDefault()
    return if e.ctrlKey
    @collection.sortStore = ""
    str = $(e.target).text()
    colName = String(str.match /[a-zA-Z]+\s*\w*[^\s]/i).replace(/\s/, '_').toLowerCase()
    if colName is "user_name"
      colName = "login_name"
    @collection.sortTableDesc(colName)
    @render

  setFilter: (e) ->
    e.preventDefault()
    newField = $(@el).find('#filterField :selected').val()
    newStartWith = $(@el).find('#filterWith :selected').val()
    newRequest = $(@el).find('#filterText').val()
    @collection.filterTable(newField, newStartWith, newRequest)
    @render

  multiSort: (e) =># NEED refactor
    e.preventDefault()
    return if not e.ctrlKey
    if e.ctrlKey 
      multiStr = $(e.target).text()
      col = String(multiStr.match /[a-zA-Z]+\s*\w*[^\s]/i).replace(/\s/, '_').toLowerCase()
      if col is "user_name"
        col = "login_name"
    @collection.sortTableMulti(col)
    @render
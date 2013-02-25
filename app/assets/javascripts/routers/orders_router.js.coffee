class Shop.Routers.Orders extends Backbone.Router

  routes:
    "orders(/)"                           : "index"
    "orders/new(/)"                       : "newOrder"
    "orders/:id/edit(/)"                  : "edit"
    #"orders/:id/order_items/:id/items(/)" : "editItem"
                
  initialize: ->
    @route /orders\/?\?(.*)/, "index", @index # orders?page=10&source=public
    @route /orders\/:id\/edit\/\?(.*)/, "edit", @edit # orders/2/edit?page=10&source=public
    @collection = new Shop.Collections.Orders($('#container').data('order'))
    @collection.setPageInfo($('#container').data('pagination'))
    @collection.fetch()         
        
  index: (params) ->
    params = _.strToParams(params)
    if params?#["orderBy"]? && params["page"]? && params["pp"]? && params["filter_by"]? && params["filter_options"]? && params["search_orders"]? && params["request"]
      @collection.setParams(params["orderBy"], params["page"], params["pp"], params["filter_by"], params["filter_options"], params["search_orders"], params["request"])
    view = new Shop.Views.OrdersIndex(collection: @collection)    
    $('#container').html(view.render().el)

  newOrder: ->
    startAttr = 
      order_number:        Math.floor(Math.random()*(99999-10000+1))+10000
      status:              ""                  
      total_price:         ""      
      total_num_of_items:  ""
      date_of_ordering:    ""
      user_id:             window.curUser.id
    @collection.create startAttr,
      wait: true
      success: =>
        order = @collection.at(@collection.length-1)
        order.order_items()
        view = new Shop.Views.OrdersNew(collection: @collection, model: order)    

  edit: (id) -> 
    # params = _.strToParams(params)
    order = @collection.get(id)  
    # order.order_items().setParams(params["orderBy"], params["page"], params["pp"]) if params["orderBy"]? && params["page"]? && params["pp"]?
    # view = new Shop.Views.OrdersEdit(model: order, collection: order.order_items())
    # view.order_id = id
    view = new Shop.Views.OrdersEdit(model: order, collection: @collection)
    
  editItem: (order_id,order_item_id) ->
    @collection_of_items = new Shop.Collections.Items()
    @collection_of_items.fetch()    
    order = @collection.get(order_id)
    view = new Shop.Views.OrderItemEdit(collection: @collection_of_items)
    view.order_id = order_id
    view.order_item_id = order_item_id    
    view.order_items_collection = order.order_items()
    $('#container').html(view.render().el)






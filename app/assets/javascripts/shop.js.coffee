window.Shop =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}

  initItems: -> 
    new Shop.Routers.Items()
    Backbone.history.start(pushState: true)

  initOrders: -> 
    new Shop.Routers.Orders()
    Backbone.history.start(pushState: true) #set -> root: "/orders" cause history must start from it

  initUsers: -> 
    new Shop.Routers.Users()
    Backbone.history.start(pushState: true)

$(document).ready ->
  Shop.initUsers() if curUser?.role == "Administrator"
  Shop.initOrders() if curUser?.role == "Customer"
  Shop.initItems() if curUser?.role == "Supervisor"
  

  
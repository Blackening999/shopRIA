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
    Backbone.history.start(pushState: true)
  
  initUsers: -> 
    new Shop.Routers.Users()
    Backbone.history.start(pushState: true)

  initOrderings: -> 
    new Shop.Routers.Orderings()
    Backbone.history.start(pushState: true)  

$(document).ready ->
  Shop.initUsers() if curUser?.role == "Administrator"
  Shop.initOrders() if curUser?.role == "Customer"
  Shop.initItems() if curUser?.role == "Supervisor"
  Shop.initOrderings() if curUser?.role == "Merchandiser"
  

  
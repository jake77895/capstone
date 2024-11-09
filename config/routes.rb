Rails.application.routes.draw do

  #Home 
  get("/", { :controller => "nav", :action => "index"})

  # Create Tier Lists
  get("/create_item_categories", { :controller => "create_tls", :action=> "create"})
  post("/create_field", { :controller => "create_tls", :action => "submit_fields"})
  get("/clear_session", { :controller => "create_tls", :action=> "clear_session"})
  get("/add_items", { :controller => "create_tls", :action => "add_items"})
  post("/submit_tl", { :controller => "create_tls", :action => "submit_tl" })

  # Fill in Tier Lists
  get("/rank_items", { :controller => "rank_tls_controller", :action => "rank"})


  
end

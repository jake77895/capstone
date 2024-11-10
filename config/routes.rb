Rails.application.routes.draw do

  # Home 
  get("/", { :controller => "nav", :action => "index"})
  root to: 'pages#home'

  # Create Tier Lists
  get("/create_item_categories", { :controller => "create_tls", :action=> "create"})
  post("/create_field", { :controller => "create_tls", :action => "submit_fields"})
  get("/clear_session", { :controller => "create_tls", :action=> "clear_session"})
  get("/add_items", { :controller => "create_tls", :action => "add_items"})
  post("/submit_tl", { :controller => "create_tls", :action => "submit_tl" })

  resources :fields, only: [:new, :create]
  resources :items, only: [:new, :create, :show]

  # Fill in Tier Lists
  get("/rank_items", { :controller => "rank_tls", :action => "rank"})

  # Login Flow
  get("/signup", { :controller => "user", :action=>"signup"})
  get("/login", { :controller => "user", :action=>"login"})

  
end

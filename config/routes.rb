Rails.application.routes.draw do
  get 'item_ranks/edit'
  get 'item_ranks/update'

  # Home 
  get("/", { :controller => "nav", :action => "index"})
  root to: 'pages#home'

  # Create Tier Lists
  get("/create_item_categories", { :controller => "create_tls", :action=> "create"})
  post("/create_field", { :controller => "create_tls", :action => "submit_fields"})
  get("/clear_session", { :controller => "create_tls", :action=> "clear_session"})
  get("/add_items", { :controller => "create_tls", :action => "add_items"})
  post("/submit_tl", { :controller => "create_tls", :action => "submit_tl" })
  # post "/submit_tl", to: "items#create", as: :submit_tl
  
  resources :tier_lists do
    resources :items, only: [:new, :create, :index] # For adding items to tier lists
    resources :item_ranks, only: [:edit, :update] # For updating ranks and other details
  end





  resources :fields, only: [:new, :create]
  resources :items, only: [:new, :create, :show]

  # Fill in Tier Lists
  get("/rank_items", { :controller => "rank_tls", :action => "rank"})


  # Login Flow
  get "/login", to: "user#login", as: :login
  get "/signup", to: "user#signup", as: :signup

  
end

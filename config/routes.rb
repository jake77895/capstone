Rails.application.routes.draw do

  # This is a blank app! Pick your first screen, build out the RCAV, and go from there. E.g.:

  # get "/your_first_screen" => "pages#first"
  get("/", { :controller => "items", :action=> "create"})
  get("/clear_session", { :controller => "items", :action=> "clear_session"})

  post("/create_field", { :controller => "items", :action => "submit"})
  get("/add_items", { :controller => "items", :action => "add_items"})
  
end

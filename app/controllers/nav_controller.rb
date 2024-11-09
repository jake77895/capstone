class NavController < ApplicationController

  def index
 
    render({ :template => "navigation_templates/home" })

  end 

end

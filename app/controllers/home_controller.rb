class HomeController < ApplicationController

  def index
    
    @published_tier_lists = TierList.where(published: true) # Fetch only published tier lists
    render({ :template => "navigation_templates/home" })

  end 

  def home
  end

end

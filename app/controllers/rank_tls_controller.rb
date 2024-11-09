class RankTlsController < ApplicationController

  def rank
 
    render({ :template => "fillTl_template/rank_items" })

  end 

end

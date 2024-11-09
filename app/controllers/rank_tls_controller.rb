class RankTlsController < ApplicationController

  def rank
 
    render({ :template => "fillTL_template/rank_items" })

  end 

end

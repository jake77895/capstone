class RankTlsController < ApplicationController

  def rank

    # Fetch all items in a specific order for ranking
    @items = Item.all.order(:id) # Adjust ordering as needed

    # Determine which item to display based on `current_item_id`
    current_index = params[:current_item_id] ? @items.index { |item| item.id == params[:current_item_id].to_i } : 0
    @current_item = @items[current_index]

    # Get the next and previous item IDs to allow navigation
    @next_item_id = @items[current_index + 1]&.id
    @previous_item_id = @items[current_index - 1]&.id if current_index > 0
 
    render({ :template => "fillTl_template/rank_items" })

  end 

end

class ItemsController < ApplicationController
  
  def rank_items
    # Get all items for ranking
    @items = Item.all.order(:id) # Adjust ordering as needed

    # Fetch the current item based on a passed `current_item_id` parameter, or start with the first item
    current_index = params[:current_item_id] ? @items.index { |item| item.id == params[:current_item_id].to_i } : 0
    @current_item = @items[current_index]
    
    # Get the next item ID for navigation purposes
    @next_item_id = @items[current_index + 1]&.id
    @previous_item_id = @items[current_index - 1]&.id if current_index > 0
  end
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)

    if @item.save
      redirect_to @item, notice: "Item was successfully created."
    else
      render :new
    end
  end

  private

  def item_params
    # Permit name, description, and custom_fields (as a hash)
    params.require(:item).permit(:name, :description, custom_fields: {})
  end
end

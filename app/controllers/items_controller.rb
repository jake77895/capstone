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
    # Extract each item from params and save it to the `items` table
    @items = item_params.map do |item_attributes|
      Item.new(item_attributes)
    end
  
    if @items.all?(&:save)
      redirect_to items_path, notice: 'Items were successfully created.'
    else
      render :new
    end
 

  end

  private

  def item_params
      # Permit each item in the array to have the specified attributes
    params.require(:items).map do |item|
      item.permit(:name, :description, :image, custom_fields: {})
    end
  end
end

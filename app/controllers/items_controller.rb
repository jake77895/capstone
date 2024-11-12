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
  
  class ItemsController < ApplicationController
    def new
      @tier_list = TierList.find(params[:tier_list_id])
      @item = Item.new
    end
  
    def create
      @tier_list = TierList.find(params[:tier_list_id])
      @item = Item.new(item_params)
  
      if @item.save
        # Create an entry in ItemRank to associate the item with the tier list
        ItemRank.create(item: @item, tier_list: @tier_list)
        redirect_to @tier_list, notice: 'Item was successfully added to the Tier List.'
      else
        render :new
      end
    end
  
    private
  
    def item_params
      # Permit standard item attributes and custom fields
      params.require(:item).permit(:name, :description, :image, custom_fields: @tier_list.custom_fields.map { |field| field['name'] })
    end
  end
  

  
end

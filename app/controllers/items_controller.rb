class ItemsController < ApplicationController
  before_action :set_tier_list, only: [:create, :show, :index]

  def set_tier_list
    @tier_list = TierList.find(params[:tier_list_id])
  end

  def show
    @item = @tier_list.items.find(params[:id])
    @tier_list = TierList.find(params[:tier_list_id])

    # Example logic to find previous and next item IDs (adjust as needed)
    previous_item_id = Item.where("id < ?", @item.id).order(id: :desc).pluck(:id).first
    next_item_id = Item.where("id > ?", @item.id).order(id: :asc).pluck(:id).first
    
  

    respond_to do |format|
      format.html # For standard page load
      format.js { render partial: 'item_card', locals: { item: @item, previous_item_id: @previous_item_id, next_item_id: @next_item_id } }
    end

    render json: {
      name: @item.name,
      description: @item.description,
      image_url: @item.image.attached? ? url_for(@item.image) : nil,
      previous_item_id: previous_item_id,
      next_item_id: next_item_id
    }
  end
  
  def index
    @tier_list = TierList.find(params[:tier_list_id])
    @items = @tier_list.items # Adjust if items are related differently
    @item = @tier_list.items.first # or set to the item you want to display

    @current_item = @items.find_by(id: params[:current_item_id]) || @items.first
    @previous_item_id = @items.where("items.id < ?", @current_item.id).last&.id
    @next_item_id = @items.where("items.id > ?", @current_item.id).first&.id


    # Render the index view or redirect as needed
    render :index
  end
  
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
    @tier_list = TierList.find(params[:tier_list_id])
    @item = Item.new
  end
  
  def create
    @tier_list = TierList.find(params[:tier_list_id])
    
    # Get the item data and process each item
    items_data = item_params || []
    Rails.logger.info("Received items_data: #{items_data.inspect}")
  
    items_data.each do |item_data|
      # Skip any item without a name
      next if item_data[:name].blank?
  
      # Ensure custom_fields is a hash
      custom_fields_data = item_data[:custom_fields].is_a?(Hash) ? item_data[:custom_fields] : item_data[:custom_fields].to_h
      Rails.logger.info("Custom fields for this item: #{custom_fields_data.inspect}")
  
      # Create the item with associated tier_list and custom_fields
      @item = @tier_list.items.build(
        name: item_data[:name],
        description: item_data[:description],
        custom_fields: custom_fields_data, # Assign custom fields here
        image: item_data[:image] # Ensure image is included here
      )

      if @item.save
        ItemRanking.create(tier_list: @tier_list, item: @item)
      else
        render :new and return
      end
    end
  
    redirect_to tier_list_items_path(@tier_list)
  end

  private

  def item_params
    params.require(:items).to_unsafe_h.map do |_, item|
      ActionController::Parameters.new(item).permit(:name, :description, :image, custom_fields: {}).to_h
    end
  end
  

  

end

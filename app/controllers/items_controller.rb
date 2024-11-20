class ItemsController < ApplicationController
  before_action :set_tier_list, only: [:create, :show, :index]
  include Rails.application.routes.url_helpers

  def set_tier_list
    @tier_list = TierList.find(params[:tier_list_id])
  end

  def show
    @tier_list = TierList.find(params[:tier_list_id])
    @item = @tier_list.items.find(params[:id])

    # Determine previous and next item IDs in the tier list
    previous_item_id = @tier_list.items.where("items.id < ?", @item.id).order("items.id DESC").pluck(:id).first
    next_item_id = @tier_list.items.where("items.id > ?", @item.id).order("items.id ASC").pluck(:id).first    

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
  
    if @tier_list.items.present?
      items = @tier_list.items.order(:id) # Ensure items are ordered
      current_item_id = params[:current_item_id] || items.first.id
  
      # Dynamically set @current_item based on params[:current_item_id]
      @current_item = items.find_by(id: current_item_id)
  
      # Determine the current item's position in the list
      current_index = items.index(@current_item)
      @next_item = items[current_index + 1] if current_index && current_index + 1 < items.size
      @previous_item = items[current_index - 1] if current_index && current_index > 0
    else
      # Handle empty tier list case
      @current_item = nil
      @next_item = nil
      @previous_item = nil
    end
  
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

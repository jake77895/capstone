class TierListsController < ApplicationController
  def index
    @tier_lists = TierList.all
  end
  
  def new
    @tier_list = TierList.new
  end

  def create
    @tier_list = TierList.new(tier_list_params)

    # Assign a default value for user_id
    @tier_list.user_id = 1  # Temporary placeholder value until users are implemented
    
      # Store custom fields in the JSON column
      @tier_list.custom_fields = extract_custom_fields(params)

    if @tier_list.save
      redirect_to tier_list_path(@tier_list), notice: 'Tier List was successfully created with custom fields.'
    else
      render :new
    end
  end

  def show
    @tier_list = TierList.find(params[:id])
    @fields = @tier_list.custom_fields.presence || []
    @item = Item.new  # Initialize a new item for the form
  end

  def publish
    @tier_list = TierList.find(params[:id])
    
    if @tier_list.update(published: true)
      redirect_to root_path, notice: "Tier list published successfully."
    else
      redirect_to root_path, alert: "Failed to publish tier list."
    end
  end

  def published
    @tier_lists = TierList.where(published: true)
  end

  private

  def tier_list_params
    params.require(:tier_list).permit(:name, :short_description)
  end

  def extract_custom_fields(params)
    # Collect custom field data from params and filter out fields with empty names
    params[:fields].values.map do |field|
      next if field[:name].blank? # Skip this field if the name is blank
      {
        name: field[:name],
        datatype: field[:datatype]
      }
    end.compact # Remove any `nil` entries from the array
  end



end

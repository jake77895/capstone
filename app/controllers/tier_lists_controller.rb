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
    
    # Process custom fields from user input and store them in the TierList
    @tier_list.custom_fields = extract_custom_fields(params)

    if @tier_list.save
      redirect_to add_items_path, notice: 'Tier List was successfully created with custom fields.'
    else
      render :new
    end
  end

  def show
    @tier_list = TierList.find(params[:id])
  end

  private

  def tier_list_params
    params.require(:tier_list).permit(:name, :short_description)
  end

  def extract_custom_fields(params)
    # Collect custom field data from params and return as an array of hashes
    params[:fields].values.map do |field|
      {
        name: field[:name],
        datatype: field[:datatype]
      }
    end
  end
end

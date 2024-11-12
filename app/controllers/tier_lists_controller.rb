# app/controllers/tier_lists_controller.rb
class TierListsController < ApplicationController
  def new
    @tier_list = TierList.new
    @fields = [
      { name: 'custom_field_1', datatype: 'text' },
      { name: 'custom_field_2', datatype: 'number' },
      # Add other custom fields as necessary
    ]
  end

  def create
    @tier_list = TierList.new(tier_list_params)
    # @tier_list.user_id = current_user.id # assuming you have a logged-in user

    if @tier_list.save
      redirect_to rank_items_path, notice: 'Tier List was successfully created.'
    else
      render :new
    end
  end

  private

  def tier_list_params
    params.require(:tier_list).permit(:name, :short_description)
  end
end

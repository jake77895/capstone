class ItemRanksController < ApplicationController
  def edit
    @item_rank = ItemRank.find(params[:id])
  end

  def update
    @item_rank = ItemRank.find(params[:id])
    if @item_rank.update(item_rank_params)
      redirect_to tier_list_items_path(@item_rank.tier_list), notice: "Item ranking updated successfully."
    else
      render :edit, alert: "Error updating ranking."
    end
  end

  private

  def item_rank_params
    params.require(:item_rank).permit(:rank, :other_info) # Permit rank and other fields you want to update
  end
end

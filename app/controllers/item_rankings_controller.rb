class ItemRankingsController < ApplicationController
  def edit
    @item_rank = ItemRank.find(params[:id])
  end

  def update
    @tier_list = TierList.find(params[:tier_list_id])
    @item = Item.find(params[:item_id])
    @item_ranking = ItemRanking.find_or_initialize_by(item: @item, tier_list: @tier_list)
  
    if @item_ranking.update(ranking: params[:ranking])
      redirect_to tier_list_items_path(@tier_list), notice: "Ranking updated successfully."
    else
      redirect_to tier_list_items_path(@tier_list), alert: "Error updating ranking."
    end
  end

  private

  def item_rank_params
    params.require(:item_rank).permit(:rank, :other_info) # Permit rank and other fields you want to update
  end
end

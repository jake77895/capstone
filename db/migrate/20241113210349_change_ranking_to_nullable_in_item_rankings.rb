class ChangeRankingToNullableInItemRankings < ActiveRecord::Migration[7.1]
  def change
    change_column_null :item_rankings, :ranking, true
  end
end

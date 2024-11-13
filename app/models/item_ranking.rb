# == Schema Information
#
# Table name: item_rankings
#
#  id           :bigint           not null, primary key
#  ranking      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  item_id      :integer          not null
#  tier_list_id :integer          not null
#
# Indexes
#
#  index_item_rankings_on_item_id       (item_id)
#  index_item_rankings_on_tier_list_id  (tier_list_id)
#
class ItemRanking < ApplicationRecord
  belongs_to :tier_list
  belongs_to :item
end

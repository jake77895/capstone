# == Schema Information
#
# Table name: tier_lists
#
#  id                :bigint           not null, primary key
#  name              :string
#  short_description :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  user_id           :integer          not null
#
# Indexes
#
#  index_tier_lists_on_user_id  (user_id)
#
class TierList < ApplicationRecord
  belongs_to :user
  has_many :item_rankings, dependent: :destroy
  has_many :items, through: :item_rankings

end

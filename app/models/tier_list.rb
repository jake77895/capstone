# == Schema Information
#
# Table name: tier_lists
#
#  id                :bigint           not null, primary key
#  custom_fields     :json
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
  has_many :item_ranks
  has_many :items, through: :item_ranks

  # Assuming `custom_fields` is serialized or stored as JSON
  serialize :custom_fields, Array
end

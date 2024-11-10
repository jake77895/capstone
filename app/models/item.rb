# == Schema Information
#
# Table name: items
#
#  id            :bigint           not null, primary key
#  custom_fields :json
#  description   :text
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Item < ApplicationRecord
end

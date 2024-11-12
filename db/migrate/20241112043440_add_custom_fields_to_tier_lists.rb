class AddCustomFieldsToTierLists < ActiveRecord::Migration[7.1]
  def change
    add_column :tier_lists, :custom_fields, :json
  end
end

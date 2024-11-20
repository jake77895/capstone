class AddPublishedToTierLists < ActiveRecord::Migration[7.1]
  def change
    add_column :tier_lists, :published, :boolean, default: false, null: false
  end
end

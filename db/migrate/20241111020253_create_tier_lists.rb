class CreateTierLists < ActiveRecord::Migration[7.1]
  def change
    create_table :tier_lists do |t|
      t.string :name
      t.integer :user_id, null: false
      t.string :short_description

      t.timestamps
    end

    add_index :tier_lists, :user_id

  end
end

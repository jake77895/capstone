class CreateItemRankings < ActiveRecord::Migration[7.1]
  def change
    create_table :item_rankings do |t|
      t.integer :tier_list_id, null: false
      t.integer :item_id, null: false
      t.integer :ranking, null: false

      t.timestamps
    end

    add_index :item_rankings, :tier_list_id
    add_index :item_rankings, :item_id
  end
end

class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name              # Standard field for the item name
      t.integer :tier_list_id     # Foreign key to associate with a specific tier list
      t.json :custom_fields       # JSON column to store customizable fields

      t.timestamps
    end

    # Adding an index on tier_list_id to improve lookup speed
    add_index :items, :tier_list_id
  end
end


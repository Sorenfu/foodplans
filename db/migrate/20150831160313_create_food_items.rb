class CreateFoodItems < ActiveRecord::Migration
  def change
    create_table :food_items do |t|
      t.string :name
      t.float :quantity
      t.string :unit
      t.integer :food_list_id

      t.timestamps
    end
  end
end

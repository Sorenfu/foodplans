class CreateRecipes < ActiveRecord::Migration
  def change
    create_table :recipes do |t|
      t.string :url
      t.string :name
      t.integer :food_list_id

      t.timestamps
    end
  end
end

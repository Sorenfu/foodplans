class CreateFoodLists < ActiveRecord::Migration
  def change
    create_table :food_lists do |t|
      t.date :date

      t.timestamps
    end
  end
end

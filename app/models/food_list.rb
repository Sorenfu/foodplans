class FoodList < ActiveRecord::Base
  has_many :food_items, dependent: :destroy
  has_many :recipes, dependent: :destroy



  validates_uniqueness_of :date

  accepts_nested_attributes_for :food_items
  accepts_nested_attributes_for :recipes
end

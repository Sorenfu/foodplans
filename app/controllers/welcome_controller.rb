class WelcomeController < ApplicationController
  def index
    @food_lists = FoodList.order(date: :desc)
  end
end

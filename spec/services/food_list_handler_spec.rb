require 'rails_helper'

describe Services::FoodListHandler do
  let(:date) { Date.parse '2015-09-01' }
  let(:date2) { Date.parse '25-08-2015' }

  it 'gets food list' do
    VCR.use_cassette('food_handler') do
      puts subject.get_list_for_week(date)
    end
  end

  it 'gets another food list' do
    VCR.use_cassette('food_handler') do
      puts subject.get_list_for_week(date2)
    end
  end

  it 'gets historical recipes' do
    VCR.use_cassette('historical_recipes') do
      Timecop.freeze(date2) do
        puts subject.get_historical_recipes(10)
      end
    end
  end
end
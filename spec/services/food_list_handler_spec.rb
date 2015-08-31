require 'rails_helper'

describe Services::FoodListHandler do
  let(:date) { Date.parse '2015-09-01' }
  let(:date2) { Date.parse '25-08-2015' }

  it 'gets food list' do
    VCR.use_cassette('food_handler') do
      expect { subject.get_list_for_week(date) }.not_to raise_error
    end
  end

  it 'gets historical recipes' do
    VCR.use_cassette('historical_recipes') do
      Timecop.freeze(date2) do
        expect { subject.get_historical_recipes(10) }.to change { FoodList.count }.by(10)
      end
    end
  end

end
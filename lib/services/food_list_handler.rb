require 'net/http'

module Services
  class FoodListHandler
    FOOD_LIST_URL = 'http://www.aarstiderne.com/Services/ItemWebService.asmx/GetBuildOfMaterial'
    RECIPE_URL = 'http://www.aarstiderne.com/Opskrifter/Menuoversigt?&persons=2&days=5&d='

    def get_list_for_week(date)
      food_items = get_food_items date
      recipes = get_recipes date.strftime('%d-%m-%Y')

      FoodList.create!(date: date, food_items_attributes: food_items, recipes_attributes: recipes)
    end

    def get_historical_recipes(weeks)
      weeks.times do |week_number|
        date = Date.parse('Tuesday') - week_number.weeks
        get_list_for_week date
      end
    end

    private

    def get_food_items(date)
      uri = URI(FOOD_LIST_URL)
      Rails.logger.info "Getting url: #{uri}"
      res = Net::HTTP.post_form(uri, itemNo: 115034, shipmentDate: date)
      raw_json = res.body.scan(/<string .*>(.*)<\/string>/).flatten.last
      json = JSON.load raw_json
      json['Components'].map { |x| {name: x['Name'], quantity: x['Quantity'], unit: x['UnitOfMeasure']} }
    end

    def get_recipes(date)
      uri = URI(RECIPE_URL + date)
      Rails.logger.info "Getting url: #{uri}"
      res = Net::HTTP.get(uri)
      doc = Nokogiri::HTML res
      meals = doc.xpath('//div[@data-family-type="LowCarb" and @data-days="5" and @data-persons="2"][1]//div[@class="meals"]/a')
      meals.map { |x| {name: x.text, url: x.xpath('.//@href').text} }
    end

  end
end
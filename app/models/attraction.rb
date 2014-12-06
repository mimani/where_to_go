class Attraction < ActiveRecord::Base
  self.inheritance_column = :_type_disabled


  def self.populate
    api_client = HolidayIQClient.new
    City.all.each { |city|
      data = api_client.get_attractions city.city_holiday_iq_id
      save_in_db data
    }

  end

  def self.save_in_db data
    data.each { |d|
      a = Attraction.create(d) }
    end
end
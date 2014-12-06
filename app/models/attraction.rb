class Attraction < ActiveRecord::Base
  self.inheritance_column = :_type_disabled

  def url
    api_client = HolidayIQClient.new
    api_client.get_attraction_details attraction_holiday_iq_id
  end

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

  def self.get_travel_related_attractions interests
    all_attractions = Attraction.select("distinct type").map(&:type).reject(&:blank?)
    # matchining_attractions = all_attractions & interests
    top_matching_attractions =  all_attractions.each_with_object({}){|a,h| h[a] = interests.count{|i| i.upcase==a.upcase} }
    p "top_matching_attractions are here #{top_matching_attractions.inspect}"
    top_matching_attractions.sort_by { |key, val| -val }[0..2].reject { |t| t[1] == 0 }.map{|a| a[0]}
  end
end
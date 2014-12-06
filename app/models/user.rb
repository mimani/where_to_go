class User
  def get_attractions
    attractions = Attraction.all.limit(3)
    city_details = {}
    attractions.map do |attr|
      city_names = Attraction.select('distinct city').where(:type => attr.type).limit(3)
      cities = City.where(:city=> city_names.map { |c| c.city})
      {
          :display_name => attr.display_name,
          :type         => attr.type,
          :cities       => cities.map { |city| get_city_details(city, city_details)}
      }
    end
  end

  private
  def get_city_details(city, city_details)
    return  city_details[city.city] if city_details[city.city]
    city.get_details
  end
end
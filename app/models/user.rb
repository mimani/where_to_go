class User
  def initialize
    # fb_client = FBClient.new
    # data = fb_client.get_interests
  end

  def get_attractions
    attractions = Attraction.all.limit(3)
    city_details = {}
    attractions.map do |attr|
      attraction_list = Attraction.where(:type => attr.type).limit(3).group("attraction").order("rank")
      response = {          :type         => attr.type      }
      response.merge(:data => attraction_list.map { |a| get_details a, city_details })
    end
  end

  private
  def get_city_details(city, city_details)
    if city_details[city.city]
      return  city_details[city.city]
    else
      details = city.get_details
      city_details[city.city] = details
    end
  end

  def get_details a, city_details
  city = City.find_by_city a.city
    {
        :display_name         => a.display_name,
        :attraction_details   => a.url,
        :city_detail          => get_city_details(city, city_details)
    }
  end


end
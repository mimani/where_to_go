require 'wordnet'
class User
  attr_reader :fb_client
  def initialize access_token, user_id
    @fb_client = FBClient.new(access_token, user_id)
  end

  def attractions
    data = fb_client.get_relevent_likes

    p "data is her e #{data.inspect}"

    tmp_data = data.map{|d| d.split(' ')}.flatten
    formatted_data = tmp_data.map{|d| d.gsub(/[^A-Za-z]/, '')}.reject(&:blank?)

    p " data is here nelkwejtk h #{formatted_data.inspect}"
    p " data 1 is eher data.first.synonyms #{formatted_data.first.synonyms}"
    p " data 1 is eher data.first.hypernyms #{formatted_data.first.hypernyms}"
    p " data 1 is eher data.first.hyponyms #{formatted_data.first.hyponyms}"
    p " data 1 is eher data.first.stem #{formatted_data.first.stem}"
    p " data 1 is eher data.first.infinitive #{formatted_data.first.infinitive}"
    p " data 1 is eher data.first.present_participle #{formatted_data.first.present_participle}"
    p " data 1 is eher data.first.plural_verb #{formatted_data.first.plural_verb}"
    p " data 1 is eher data.first.plural #{formatted_data.first.plural}"
    p " data 1 is eher data.first.singular #{formatted_data.first.singular}"


    related_data = formatted_data.map { |d|
      d.synonyms + d.hypernyms + d.hyponyms + [d.stem] + [d.infinitive] + [d.present_participle] + [d.plural_verb] + [d.plural] + [d.singular]}
    p "finally exxtracted are #{related_data.inspect}"
    attractions = Attraction.get_travel_related_attractions(related_data.flatten.compact.reject(&:blank?))

    get_attractions attractions
  end

  def similar_places
    tagged_places = fb_client.get_tagged_places

  end

  def get_attractions attractions
    city_details = {}
    attractions.map do |attr|
      attraction_list = Attraction.where(:type => attr).limit(3).group("attraction").order("rank")
      response = { :type => attr }
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
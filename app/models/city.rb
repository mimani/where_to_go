class City < ActiveRecord::Base
  attr_accessor :password

  # Validations
  validates_presence_of     :city,    :city_holiday_iq_id
  # validates_length_of       :city,    :within => 2..100
  # validates_uniqueness_of   :city,    :case_sensitive => false

  def self.pupulate
    api_client = HolidayIQClient.new
    cities = api_client.get_all_city_data
    data = cities.map { |city| City.new(:city => city[:name],
                                 :city_holiday_iq_id => city[:id],
                                 :state => city[:state]
    ) }
    save_in_db data
  end

  def self.find_listed_cities list
    City.where(:city => list).limit(3)
  end

  def find_similar_cities
    query = "select type, count(*) as c from attractions where city = '#{city}' group by type order by c desc limit 2;"
    top_attr_types = ActiveRecord::Base.connection.execute(query)
    p "top_attr_types are here #{top_attr_types.inspect}"
    top_types = top_attr_types.map { |tat| tat[0] }
    p "for #{city} types are #{top_types}"

    similar_cities_query = "select a1.city,  a1.type, a2.type,  count(*) as c from attractions  a1
                                  join attractions a2 on a1.city = a2.city
                                  where   a1.type = '#{top_types[0]}' and a2.type = '#{top_types[1]}' and a1.city != '#{city}'
                                  group by a1.city, a1.type, a2.type  order by c desc limit 3 ;"
    similar_cities = ActiveRecord::Base.connection.execute(similar_cities_query)
    type_hash = {  :type_1 => top_types[0], :type_2 => top_types[1]   }
    similar_cities_res =similar_cities.map { |sc| City.find_by_city(sc[0]).get_details }
    return type_hash, similar_cities_res
  end

  def get_details
    api_client = HolidayIQClient.new
    api_client.get_city_details self.city_holiday_iq_id
  end

  def self.save_in_db data
    data.each { |d| d.save! }
  end

  def hotels
    api_client = HolidayIQClient.new
    hotels = api_client.get_hotels city_holiday_iq_id
  end
end
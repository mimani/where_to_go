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
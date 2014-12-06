class CityAttractionMapping < ActiveRecord::Base

  validates_presence_of     :city, :attraction, :city_id, :attraction_id
  validates_uniqueness_of   :email,    :scope => :attraction


end
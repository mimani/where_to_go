WhereToGo::App.controllers :hotels do
  get "/:city", :provides => :json do

    city = City.find_by_city(params[:city])
    raise "City not Found" if city.blank?
    return {:hotels => city.hotels}.to_json
  end

end
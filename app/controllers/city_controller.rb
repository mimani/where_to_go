WhereToGo::App.controllers :cities do
  get "/:id", :provides => :json do
    raise if params["id"].blank?
    City.find(params["id"])
    status 200
  end

  post "/populate", :provides => :json do
    api_client = HolidayIQClient.new
    City.pupulate
    status 200
  end
end
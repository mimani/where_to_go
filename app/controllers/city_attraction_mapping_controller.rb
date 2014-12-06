WhereToGo::App.controllers :city_attraction_mappings do
  get "/", :provides => :json do
    #   Fetch attraction data for a user
  end

  post "/populate", :provides => :json do
    Attraction.populate
  end
end
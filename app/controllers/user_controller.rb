WhereToGo::App.controllers :users do
  get "/interests", :provides => :json do
    user  = User.new()
    return {:attractions => user.get_attractions}.to_json
  end

end
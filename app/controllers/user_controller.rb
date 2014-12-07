WhereToGo::App.controllers :users do
  get "/interests", :provides => :json do
    # access_token =  params[:access_token] || 'CAACEdEose0cBAP17HyCr4h5fxhaECOLIa7c0m3UXDzbI7sZA5DYV0c46K6JtFZBelbRQo5A8Pnzoudpi0Retn37HV0LKBN0XgWb55MphNDj2HZBinmILD5rfMIeBKZBxvASybK0r9UYji9ixD7o9raXbiLL0MaoOWSZAixBN08jZA57nYIuEmgZAdXZAAZCeewAFyBQ1LIeKgBVvY7J6fgUhHCJbRLiE6HXQZD'
    access_token =  params[:access_token] || 'CAACEdEose0cBAHR431A8AFTBKflqu1uGZBYPYcmjZBDfhfdqAv6gLt7RF2rj0Y3pWMkbEcE6vbKSrpPsmlitUbH1NXEDYR30eXArfEVEvU98nFw22raLK0UyItkHWNGx5rQSEYktmpqdy2ui0qJZAkNb5ekOZC1qCrDAoPLDjFAnyhVnIkD5ZCd3se33maDaF2UmOrawZAFQZDZD'
    # user_id = params[:user_id] || '100000867712264'
    user_id = params[:user_id] || '10203324051522378'

    user  = User.new(access_token, user_id)
    return {:attractions => user.attractions}.to_json
  end

  get "/similar_places", :provides => :json do
    # access_token =  params[:access_token] || 'CAACEdEose0cBAP17HyCr4h5fxhaECOLIa7c0m3UXDzbI7sZA5DYV0c46K6JtFZBelbRQo5A8Pnzoudpi0Retn37HV0LKBN0XgWb55MphNDj2HZBinmILD5rfMIeBKZBxvASybK0r9UYji9ixD7o9raXbiLL0MaoOWSZAixBN08jZA57nYIuEmgZAdXZAAZCeewAFyBQ1LIeKgBVvY7J6fgUhHCJbRLiE6HXQZD'
    access_token =  params[:access_token] || 'CAACEdEose0cBAHR431A8AFTBKflqu1uGZBYPYcmjZBDfhfdqAv6gLt7RF2rj0Y3pWMkbEcE6vbKSrpPsmlitUbH1NXEDYR30eXArfEVEvU98nFw22raLK0UyItkHWNGx5rQSEYktmpqdy2ui0qJZAkNb5ekOZC1qCrDAoPLDjFAnyhVnIkD5ZCd3se33maDaF2UmOrawZAFQZDZD'
    # user_id = params[:user_id] || '100000867712264'
    user_id = params[:user_id] || '10203324051522378'

    user  = User.new(access_token, user_id)
    return {:similar_places => user.similar_places}.to_json
  end

end
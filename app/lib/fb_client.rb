class FBClient
  attr_reader :access_token, :user_id
  INTERESTED_CATEGORIES = ['Interest', 'Sport', 'Community']

  def initialize access_token, user_id
    @access_token = access_token
    @user_id = user_id
  end

  def get_relevent_likes
    data = get_interests
    relevent_data = data.select{|d| INTERESTED_CATEGORIES.include?(d[:category])}
    relevent_data.map { |r| r[:name]}
  end

  def get_interests
    begin
      data = []
      fb_base_url = 'https://graph.facebook.com/v2.2'
      url =  "#{fb_base_url}/#{user_id}/likes?access_token=#{access_token}"
      while true do
        p "url here #{url}"
        response = RestClient.get url
        parsed_response = JSON.parse(response.body)
        likes = parsed_response["data"]
        data += likes.map{|like| { :category => like["category"], :name => like["name"]}}
        if parsed_response["paging"]["next"]
          url = parsed_response["paging"]["next"]
          break unless url
        else
          break
        end
      end
      data
    rescue RestClient::ResourceNotFound => exception
      logger.error "ResourceNotFound Exeption"
      ExceptionHelper.raise_invalid_data_error(exception)
    rescue Exception => e
      p "Exeption #{e} "
      raise "FB Exeption"
    end
  end


end
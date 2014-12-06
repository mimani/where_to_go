class FBClient
  attr_reader :access_token, :user_id

  def initialize
    @access_token = 'CAACEdEose0cBAMh18iWemiLHKfHlIgpUX3P3JGY5rMbBDcZC8ARN1GIw6r3ZCH9u8jPv6Cpf82aOWOaLPlSZChevKoIM6ZCbyYYIwNtPjZChgdC6QeUpi503d618ZBOxeZBX3uHRvqp8AKkZClmwO4tDkOERdZAiZB146uDtVEFYP09i44xGYOlqE4ggIOLD0VZAZAIMoMjqDZBHA9qHSrTp9UOrW6Qa5ZA4xwCh8ZD'
    @user_id = '100000867712264'
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
        end
      end
      data
    rescue RestClient::ResourceNotFound => exception
      logger.error "ResourceNotFound Exeption"
      ExceptionHelper.raise_invalid_data_error(exception)
    rescue Exception => e
      logger.error "Exeption #{e} "
      raise InvalidDataError.new({:code => :APL_GET_INVOICE_FAILED, :message => "FB Exeption"}, 408)
    end
  end


end
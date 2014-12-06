class HolidayIQClient
  def get_all_city_data
    begin
      city_array = []
      45.times{|page|
        url = "http://sandbox.holidayiq.com/destinations?page=#{page+1}"
        response = RestClient.get url, {"Authorization" => "Basic dGhhY2s6dGhhY2tAaGlx"}
        parsed_response = JSON.parse(response.body)
        destinations = parsed_response["_embedded"]["destinations"]
        city_array += destinations.map{|des| { :id => des["id"], :name => des["displayName"], :state => des["stateName"]}}
      }
      city_array
    rescue RestClient::ResourceNotFound => exception
      logger.error "ResourceNotFound Exeption"
      ExceptionHelper.raise_invalid_data_error(exception)
    rescue Exception => e
      logger.error "Exeption #{e} "
      raise InvalidDataError.new({:code => :APL_GET_INVOICE_FAILED, :message => "Exeption"}, 408)
    end
  end

  def get_city_details city_id
    begin
      url = "http://sandbox.holidayiq.com/destinations/#{city_id}"
      response = RestClient.get url, {"Authorization" => "Basic dGhhY2s6dGhhY2tAaGlx"}
      parsed_response = JSON.parse(response.body)
      {:description => parsed_response['shortDescription'],
       :city => parsed_response['displayName'],
       :state => parsed_response['stateName'],
       :best_photo_url => parsed_response['bestPhotoUrl'],
       :cover_photo_url => parsed_response['coverPhotoUrl'],
       :hotels_count => parsed_response['hotelsCount']
      }
    rescue RestClient::ResourceNotFound => exception
      logger.error "ResourceNotFound Exeption"
      ExceptionHelper.raise_invalid_data_error(exception)
    rescue Exception => e
      logger.error "Exeption #{e} "
      raise InvalidDataError.new({:code => :APL_GET_INVOICE_FAILED, :message => "Exeption"}, 408)
    end
  end


  def get_attraction_details attraction_id
    begin
      url = "http://sandbox.holidayiq.com/attractions/#{attraction_id}"
      response = RestClient.get url, {"Authorization" => "Basic dGhhY2s6dGhhY2tAaGlx"}
      parsed_response = JSON.parse(response.body)
      {:description => parsed_response['description'],
       :url => parsed_response['bestPhotoUrl'],
      }
    rescue RestClient::ResourceNotFound => exception
      logger.error "ResourceNotFound Exeption"
      ExceptionHelper.raise_invalid_data_error(exception)
    rescue Exception => e
      logger.error "Exeption #{e} "
      raise InvalidDataError.new({:code => :APL_GET_INVOICE_FAILED, :message => "Exeption"}, 408)
    end
  end

    def get_attractions city_id
    begin
      data = []
      url = "http://sandbox.holidayiq.com/attractions?destination_id=#{city_id}"
      while true do
        p "url here #{url}"
        response = RestClient.get url, {"Authorization" => "Basic dGhhY2s6dGhhY2tAaGlx"}
        parsed_response = JSON.parse(response.body)

        attractions = parsed_response["_embedded"]["attractions"]
        data += attractions.map{|des| { :attraction_holiday_iq_id => des["id"], :attraction => des["destinationName"], :display_name => des["displayName"],
                                        :city => des["destination"], :type => des["type"] , :rank => des["rank"]  }}
        p "It got some response"
        p "links are here #{parsed_response["_links"].inspect} "
        if parsed_response["_links"]["next"]
          url = parsed_response["_links"]["next"]["href"]
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
      logger.error "Exeption #{e} "
      raise InvalidDataError.new({:code => :APL_GET_INVOICE_FAILED, :message => "Exeption"}, 408)
    end
  end


end
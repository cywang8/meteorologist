require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    # create array of words in user-entered street address
    split_address = @street_address.gsub(/[^a-z0-9\s]/i, "").split
    count = split_address.length
    address_string = ""

    # use loop to create string with "+"
    i = 0
    while i <= count - 1
        address_string + "+" + split_address[i]
    end

    # add string to geocode url
    geocode_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address_string

    # use geocode API to find latitude and longitude
    parsed_data = JSON.parse(open(geocode_url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude
    @longitude = longitude

    # add latitude and longitude to forecast URL
    forecast_url = "https://api.darksky.net/forecast/a8a61fc4bcbfb3949bcaeecac2cd2c41/" + @latitude + "/" + @longitude

    parsed_forecast = JSON.parse(open(forecast_url).read)

    # pull forecast from forecast API
    @current_temperature = parsed_forecast["currently"]["temperature"]

    @current_summary = parsed_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_forecast["daily"]["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end

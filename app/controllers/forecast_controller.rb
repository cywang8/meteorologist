require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

    forecast_url = "https://api.darksky.net/forecast/a8a61fc4bcbfb3949bcaeecac2cd2c41/" + @Lat + "/" + @Lng

    parsed_forecast = JSON.parse(open(forecast_url).read)

    @current_temperature = parsed_forecast["currently"]["temperature"]

    @current_summary = parsed_forecast["currently"]["summary"]

    @summary_of_next_sixty_minutes = parsed_forecast["minutely"]["summary"]

    @summary_of_next_several_hours = parsed_forecast["hourly"]["summary"]

    @summary_of_next_several_days = parsed_forecast["daily"]["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end

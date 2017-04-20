require 'open-uri'

class GeocodingController < ApplicationController
  def street_to_coords_form
    # Nothing to do here.
    render("geocoding/street_to_coords_form.html.erb")
  end

  def street_to_coords
    @street_address = params[:user_street_address]

    # ==========================================================================
    # Your code goes below.
    #
    # The street address that the user typed is in the variable @street_address.
    # ==========================================================================

    split_address = @street_address.gsub(/[^a-z0-9\s]/i, "").split
    count = split_address.length
    address_string = ""

    i = 0
    while i <= count - 1
        address_string + "+" + split_address[i]
    end

    geocode_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + address_string

    parsed_data = JSON.parse(open(geocode_url).read)
    latitude = parsed_data["results"][0]["geometry"]["location"]["lat"]
    longitude = parsed_data["results"][0]["geometry"]["location"]["lng"]

    @latitude = latitude
    @longitude = longitude

    render("geocoding/street_to_coords.html.erb")
  end
end

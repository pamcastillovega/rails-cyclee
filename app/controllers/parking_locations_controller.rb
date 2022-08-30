class ParkingLocationsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @parkinglocations = ParkingLocations.all
    @markers = @parkinglocations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
  end
end

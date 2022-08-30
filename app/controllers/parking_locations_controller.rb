class ParkingLocationsController < ApplicationController
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

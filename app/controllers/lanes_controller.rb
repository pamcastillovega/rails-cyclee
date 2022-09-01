class LanesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @lanes = Lane.all
    @lane = Lane.last
    @parkinglocations = ParkingLocation.all
    @markers = @parkinglocations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
  end

  def sample
  end
end

class LanesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @lanes = Lane.all
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

  def show
  @user = User.first
  @report = Report.first
  @review = Review.first
  @lane = Lane.first



  end
end

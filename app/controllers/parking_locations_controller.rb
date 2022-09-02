class ParkingLocationsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def new
    @parking_location = ParkingLocation.new
  end
end

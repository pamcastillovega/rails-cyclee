class ParkingLocationsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @parking_location = ParkingLocation.new
  end

  def create
    @parking_location = ParkingLocation.new(location_params)
    if @parking_location.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def location_params
    params.require(:parking_location).permit(:address, :photo)
  end
end

class ParkingLocationsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
  end

  def new
    @parking_location = ParkingLocation.new
    @lane = Lane.find_by(objectid: params[:objectid])
    # @parking_locations = @lane.parking_locations
  end

  def create
    @parking_location = ParkingLocation.new(location_params)
    @lane = Lane.find(params[:lane_id])
    @parking_location.lane = @lane
    @parking_location.user = current_user
    if @parking_location.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
   end
  end

  private

  def location_params
    params.require(:parking_location).permit(:objectid, :address, :photo)

  end
end

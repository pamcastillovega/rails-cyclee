class ParkingHistoriesController < ApplicationController
  def show
    # @parking_history = ParkingHistory.find(params[:id])
    # @parking_locations = ParkingLocation.for(@parking_history.user)
  end

  def index
    @parking_history = ParkingHistory.find(params[:id])
    @parking_locations = ParkingLocation.for(@parking_history.user)
  end

end

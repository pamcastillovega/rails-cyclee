class ParkingHistoriesController < ApplicationController
  def show
    @parking_history = ParkingHistory.find(params[:id])

  end


end

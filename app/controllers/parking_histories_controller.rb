class ParkingHistoriesController < ApplicationController
  # def show
    # @parking_history = ParkingHistory.find(params[:id])
  # end

  def index
    @parking_histories = ParkingHistory.find(params[:user_id])
  end


end

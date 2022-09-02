class ParkingHistoriesController < ApplicationController
  def index
    @user = current_user
  end

  def show
    @parking_history = ParkingHistory.find(params[:id])
end

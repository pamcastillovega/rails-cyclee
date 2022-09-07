class ParkingHistoriesController < ApplicationController
  def create
    @user = current_user
    @parkinglocation = ParkingLocation.find(params[:parking_location_id])
    @parking_histories = ParkingHistory.new(user: @user, parking_location: @parkinglocation)
    if @parking_histories.save
      redirect_to users_path(@user)
    else
      render :new, status: :unprocessable_entity
    end
  end
end

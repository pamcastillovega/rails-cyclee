class UsersController < ApplicationController
  def show
    @user = current_user
    @parking_history = ParkingHistory.all
  end


end

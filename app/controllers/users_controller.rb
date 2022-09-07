class UsersController < ApplicationController
  def show
    @user = current_user
    @lng = @user.parking_histories.last.parking_location.longitude
    @lat = @user.parking_histories.last.parking_location.latitude
  end
end

class UsersController < ApplicationController
  def show
    @user = current_user
    @lng = @user.parking_histories.last.parking_location.longitude
    @lat = @user.parking_histories.last.parking_location.latitude
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:photo)
  end

end

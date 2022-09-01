class UsersController < ApplicationController
  def parking_histories
    @user = current_user
  end
end

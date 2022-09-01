class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @parking_location = ParkingLocation.find(params[:parking_location_id])
    @reports = Report.where(parking_location: @parking_location)
  end

  def create
  end
end

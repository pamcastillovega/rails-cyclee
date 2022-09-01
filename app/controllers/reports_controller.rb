class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new]

  def index
    @parking_location = ParkingLocation.find(params[:parking_location_id])
    @reports = @parking_location.reports
    @report = Report.new
  end

  def new

  end

  def create
  end
end

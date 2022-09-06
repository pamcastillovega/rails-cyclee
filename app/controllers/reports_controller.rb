class ReportsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index new]

  def index
    @parkinghistory = ParkingHistory.new
    @parking_location = ParkingLocation.find(params[:parking_location_id])
    @reports = @parking_location.reports.reverse
    @report = Report.new
    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "reports/index", locals: { report: @report, reports: @reports, parking_location: @parking_location }, formats: [:html] }
    end
  end

  def new
    @parking_location = ParkingLocation.find(params[:parking_location_id])
    @reports = @parking_location.reports
    @report = Report.new
  end

  def create
    @report = Report.new(report_params)
    @parking_location = ParkingLocation.find(params[:parking_location_id])
    @report.parking_location = @parking_location
    @report.user = current_user
    if @report.save
      redirect_to parking_location_reports_path(@parking_location)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def report_params
    params.require(:report).permit(:comment, :photo, :date, :time)
  end
end

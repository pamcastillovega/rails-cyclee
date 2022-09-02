class LanesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @lanes = Lane.all
    @lane = Lane.last
    @parkinglocations = ParkingLocation.all
    @markers = @parkinglocations.geocoded.map do |location|
      {
        lat: location.latitude,
        lng: location.longitude,
        info_window: render_to_string(partial: "info_window", locals: { location: location })
      }
    end
  end

  def show
    @lane = params[:objectid].present? ? Lane.find_by(objectid: params[:id]) : Lane.find(params[:id])
    @reviews = @lane.reviews
    @ratings = []
    @reviews.each do |review|
      @ratings << review.rating
    end
    @avgrating = @ratings.length.zero? ? 0 : @ratings.sum / @ratings.length

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "lanes/show", locals: { lane: @lane, reviews: @reviews, ratings: @ratings, avgrating: @avgrating }, formats: [:html] }
    end
  end

  def sample
  end
end

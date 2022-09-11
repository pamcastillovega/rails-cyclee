class LanesController < ApplicationController

  def index
    @lanes = Lane.all
    @lane = Lane.last
    @parkinglocations = ParkingLocation.all
    @markers = @parkinglocations.geocoded.map do |location|
      if location.reports.present?
        {
          lat: location.latitude,
          lng: location.longitude,
          id: location.id,
          image_url: helpers.asset_url("square-parking-solid.svg"),
          flagged: true
          # info_window: render_to_string(partial: "info_window", locals: { location: location })
        }
      else
        {
          lat: location.latitude,
          lng: location.longitude,
          id: location.id,
          image_url: helpers.asset_url("square-parking-solid.svg")
          # info_window: render_to_string(partial: "info_window", locals: { location: location })
        }
      end
    end

    if params[:query].present?
      lane_names = params[:query].split(",")
      lane_names.map! { |lane| lane.gsub("Street", "St") }
      lane_names.map! { |lane| lane.gsub("Road", "Rd") }
      @lanes_filter = @lanes.select { |lane| lane_names.include?(lane.name) }
      @lanes_filter = @lanes_filter.uniq(&:name)
      @lanes_filter.map!(&:id)
    end

    respond_to do |format|
      format.html # Follow regular flow of Rails
      format.text { render partial: "lanes/reviewbutton", locals: { lanes: @lanes_filter }, formats: [:html] }
    end
  end

  def show
    @lane = Lane.find_by(objectid: params[:id])
    @reviews = @lane.reviews.reverse
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

  def update
  end

  def color_update
    @lane = Lane.find(params[:id])
    ratings = []
    @lane.reviews.each do |review|
      ratings << review.rating
    end
    average = ratings.length.zero? ? 0 : ratings.sum / ratings.length

    case average
    when 1..2
      @lane.color = "#DB4437"
    when 3
      @lane.color = "#F4B400"
    when 3..5
      @lane.color = "#0F9D58"
    else
      @lane.color = "#616161" if lane.color.nil?
    end
    @lane.save!
    redirect_to lanes_path
  end

  def journeyreview
    @lanes = []
    lane_ids = params[:laneIds].split(',')
    lane_ids.map!(&:to_i)
    lane_ids.each { |id| @lanes << Lane.find(id) }

    @review = Review.new
    # @reviews = @lane.reviews
    # @ratings = []
    # @reviews.each do |review|
    #   @ratings << review.rating
    # end
    # @avgrating = @ratings.length.zero? ? 0 : @ratings.sum / @ratings.length
  end
end

# a = params[:id].split(",")
# a.map! { |n| n.to_i }
# a.each_with_index do |id, ind|
#   lane"#{ind}" = Lane.find(id)
# end

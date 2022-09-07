class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @review = Review.new
    @lane = Lane.find_by(objectid: params[:objectid])
    @reviews = @lane.reviews
    @ratings = []
    @reviews.each do |review|
      @ratings << review.rating
    end
    @avgrating = @ratings.length.zero? ? 0 : @ratings.sum / @ratings.length
  end

  def create
    @review = Review.new(review_params)
    @lane = Lane.find(params[:lane_id])
    @review.lane = @lane
    @review.user = current_user
    if @review.save
      redirect_to color_update_lane_path(@lane)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :photo, :objectid)
  end
end

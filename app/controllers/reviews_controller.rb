class ReviewsController < ApplicationController
  skip_before_action :authenticate_user!

  def new
    @review = Review.new
    @lane = Lane.find(params[:lane_id])

    # @user = User.first
    # @report = Report.first
    # @review = Review.first
    # @lane = Lane.first
  end

  def create
    @review = Review.new(review_params)
    @lane = Lane.find(params[:lane_id])
    @review.lane = @lane
    @review.user = current_user
    if @review.save!
     redirect_to lane_path(@lane)
    else
     render :new, status: :unprocessable_entity
    end
   end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :photo)
  end
end

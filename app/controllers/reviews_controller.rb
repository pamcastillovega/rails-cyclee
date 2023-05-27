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

    respond_to do |format|
      if @review.save
        @lane.color_update!
        format.html { redirect_to root_path }
        format.text { render partial: 'lanes/completed', formats: :html }
      else
        format.text { render partial: 'lanes/form', formats: :html, locals: { lane: @lane, review: @review } }
      end
    end
    # respond_to do |format|
    #   if @review.save
    #     format.html { redirect_to color_update_lane_path(@lane) }
    #     format.json
    #   else
    #     format.html { render "restaurants/show", status: :unprocessable_entity }
    #     format.json
    #   end
    # end


  end

  private

  def review_params
    params.require(:review).permit(:comment, :rating, :photo, :objectid)
  end
end

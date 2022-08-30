class LanesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @lanes = Lane.all
    # @markers = @lanes.geocoded.map do |lane|
    #   {
    #     lat: lane.latitude,
    #     lng: lane.longitude,
    #     info_window: render_to_string(partial: "info_window", locals: { lane: lane })
    #   }
    # end
  end
end

class Api::LanesController < ApplicationController
  def index
    @lanes = Lane.all
  end
end

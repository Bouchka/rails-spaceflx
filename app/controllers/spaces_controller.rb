class SpacesController < ApplicationController
  def index
    @spaces = Space.all
  end

  def show
  end
end

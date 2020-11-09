class SpacesController < ApplicationController
  def index
    @spaces = Space.all
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.owner_id = current_user.id

    if @space.save
      redirect_to @space
    else
      render :new
    end
  end

  def show
  end

  private

  def space_params
    params.require(:space).permit(:name, :capacity, :area, :price_per_day, :description, :photo)
  end
end

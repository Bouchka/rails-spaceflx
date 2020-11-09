class SpacesController < ApplicationController
  def show
    @space = Space.find(params[:id])
  end

  private
  def space_params
    params.require(:space).permit(:name, :price, :start_date, :end_date, :capacity)
  end
end

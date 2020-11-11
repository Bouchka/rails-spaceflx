class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    @spaces = Space.all

    # 'geocoded' scope filters only spaces with coordinates
    @markers = @spaces.geocoded.map do |space|
      {
        lat: space.latitude,
        long: space.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { space:space })
      }
    end
  end

  def new
    @space = Space.new
  end

  def create
    @space = Space.new(space_params)
    @space.owner_id = current_user.id

    if @space.save
      redirect_to host_dashboard_path
    else
      render :new
    end
  end

  def show
    @space = Space.find(params[:id])
    @owner = User.find(@space.owner_id)
    @booking = Booking.new
  end

  private
  def space_params
    params.require(:space).permit(:name, :price, :start_date, :end_date, :capacity)
  end

  private

  def space_params
    params.require(:space).permit(:name, :capacity, :address, :area, :price_per_day, :description, :photo)
  end
end

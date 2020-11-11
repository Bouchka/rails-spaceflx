class SpacesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  def index
    if params[:query].present?
      @search_term = params[:query]
      @spaces = Space.near(params[:query], 100)
    else
      @spaces = Space.all
    end

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
    @booking = Booking.new
    @markers =
    {
      lat: @space.latitude,
      long: @space.longitude,
      infoWindow: render_to_string(partial: "info_window", locals: { space: @space })
    }
  end

  def destroy
    @space = Space.find(params[:id])
    @space.destroy
    redirect_to host_dashboard_path
  end

  def edit
    @space = Space.find(params[:id])
  end

  def update
    @space = Space.find(params[:id])

    if @space.update(space_params)
      redirect_to host_dashboard_path
    else
      render :edit
    end
  end

  private

  def space_params
    params.require(:space).permit(:name, :capacity, :address, :area, :price_per_day, :description, :photo)
  end
end

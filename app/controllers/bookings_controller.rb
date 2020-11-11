class BookingsController < ApplicationController
  # def new
  #   @space = Space.find(params[:space_id])
  #   @booking = Booking.new
  # end

  def create
    # get the space id use wants to book
    @space = Space.find(params[:space_id])
    # create a new instance of booking class
    # thats will take start and end date from the booking form
    @booking = Booking.new(booking_params)
    # assign space_id, user_id and price_per_day to the booking
    @booking.space = @space
    # assign booking user to current_user
    @booking.user = current_user
    # TODO how to make @booking.price_per_day a static?
    @booking.price_per_day = @space.price_per_day
    # raise
    if @booking.save
      flash[:notice] = "Your booking is confirmed!"
      redirect_to space_booking_path(@space, @booking)
    else
      flash[:notice] = "Selected dates are not available :("
      redirect_to space_path(@space)
    end
  end

  def show
    @reservation = Booking.find(params[:id])
    @space = Space.find(params[:space_id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

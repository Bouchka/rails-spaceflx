class BookingsController < ApplicationController

  # def new
  #   @space = Space.find(params[:space_id])
  #   @booking = Space.new
  # end

  def create
    # get the space id use wants to book
    @space = Space.find(params[:space_id])
    # create a new instance of booking class
    # thats will take start and end date from the booking form
    @booking = Booking.new(booking_params)
    # assign space_id, user_id and price_per_day to the booking
    @booking.space = @space
    # TODO => how to ask user to login/sign up before booking
    @booking.user = current_user
    # TODO => how to make @booking.price_per_day a static?
    @booking.price_per_day = @space.price_per_day
    # TODO => loop to check that the space is available
    # at the dates entered in the form
    # if available
        # => post book
        # => direct to bookings dashboard
    # if not available
        # => stay on same page
        # => display message
    #raise
    if @booking.save
      flash[:notice] = "Your booking is confirmed!"
      redirect_to space_path(@space)
    else
      flash[:notice] = "Dates not available :("
      redirect_to space_path(@space)
    end
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

end

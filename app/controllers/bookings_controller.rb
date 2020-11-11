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
    # TODO => how to make @booking.price_per_day a static?
    @booking.price_per_day = @space.price_per_day
    # current_user date input in form
    requested_arrival_date =@booking.start_date
    requested_departure_date = @booking.end_date
    # all existing bookings for that space
    existing_bookings = @space.bookings
    # for each [start_date, end_date] in space bookings
    # arrival_date should be before start_date -> < start_date
    # and departure_date should be after end_date -> > end_date

    # @date_start.between?(arival_date, leave_date) || @date_end.between?(arival_date, leave_date)
    # at the dates entered in the form

    # if available
        # => post book
        # => direct to bookings dashboard
    # if not available
        # => stay on same page
        # => display message
    #raise
    if is_available?(existing_bookings, requested_arrival_date, requested_departure_date)
      @booking.save
      flash[:notice] = "Your booking is confirmed!"
      redirect_to space_booking_path(@space, @booking)
    else
      flash[:notice] = "Dates not available :("
      redirect_to space_path(@space)
    end
  end

  def show
    @space = Space.find(params[:space_id])
    @booking = Booking.find(params[:id])
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def is_available?(existing_bookings, requested_arrival_date, requested_departure_date)
      existing_bookings.each do |booking|
      if requested_arrival_date.between?(booking.start_date, booking.end_date) || requested_departure_date.between?(booking.start_date, booking.end_date)
        return false
      else
        return true
      end
    end
  end

end

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
      flash[:notice] = "Please correct your date selection"
      render 'spaces/show'
    end
  end

  def show
    @booking = Booking.find(params[:id])
    @space = Space.find(params[:space_id])
    @days = (@booking.end_date.to_date - @booking.start_date.to_date).to_i+1
    @total = (@days * @booking.price_per_day)
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    flash[:notice] = "Your booking has been succesfully deleted!"
    redirect_to user_dashboard_path(@booking)
  end

  private

  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end
end

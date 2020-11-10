class DashboardsController < ApplicationController

  def host
    @spaces = current_user.spaces
    @bookings = current_user.bookings
  end

  def user
    @bookings = Booking.where(user_id: current_user.id)
  end
end

class DashboardsController < ApplicationController

  def host
    @spaces = Space.where(owner_id: current_user.id)
  end

  def user
    @bookings = Booking.where(user_id: current_user.id)
  end
end

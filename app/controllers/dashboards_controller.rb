class DashboardsController < ApplicationController

  def host
    @spaces = current_user.spaces
    @bookings = current_user.bookings
  end

  def user
    @reservations = current_user.reservations
  end
end

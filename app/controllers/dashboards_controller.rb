class DashboardsController < ApplicationController

  def host
    @spaces = Space.where(owner_id: current_user.id)
  end
end

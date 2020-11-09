class Space < ApplicationRecord
  has_many :bookings
  #mount_uploader :photo, PhotoUploader

  def index
    @spaces = Space.all
  end

end

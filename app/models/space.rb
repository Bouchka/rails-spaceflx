class Space < ApplicationRecord
  has_many :bookings, dependent: :restrict_with_error

end

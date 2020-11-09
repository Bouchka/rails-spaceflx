class Space < ApplicationRecord
  has_many :bookings, dependent: :restrict_with_error

  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :price_per_day, presence: true
  validates :area, inclusion: { in: %w['Jumeirah 1' DIFC 'Dubai Marina' 'Dubai Knowledge Park' 'Downtown Dubai' 'Business Bay' 'The Palm Jumeirah'] }

end

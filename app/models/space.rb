class Space < ApplicationRecord
  has_one_attached :photo
  geocoded_by :address
  afer_validation :geocode, if: :will_save_change_to_address?
  has_many :bookings, dependent: :restrict_with_error

  ZONES = ['Jumeirah 1', 'DIFC', 'Dubai Marina', 'Dubai Knowledge Park', 'Downtown Dubai', 'Business Bay', 'The Palm Jumeirah']
  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :price_per_day, presence: true
  # validates :area, inclusion: { in: Space::ZONES }
  validates :address, presence: true

end

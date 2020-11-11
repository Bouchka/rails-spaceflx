class Space < ApplicationRecord
  has_one_attached :photo
  geocoded_by :address
  after_validation :update_coordinates, if: :will_save_change_to_address?
  has_many :bookings, dependent: :restrict_with_error
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'

  ZONES = ['Jumeirah 1', 'DIFC', 'Dubai Marina', 'Dubai Knowledge Park', 'Downtown Dubai', 'Business Bay', 'The Palm Jumeirah']
  validates :name, presence: true
  validates :description, presence: true
  validates :capacity, presence: true
  validates :price_per_day, presence: true
  # validates :area, inclusion: { in: Space::ZONES }
  validates :address, presence: true

  private

  def update_coordinates
    result = Geocoder.search(self.address).first&.data

    return if result.nil?

    self.latitude = result['lat']
    self.longitude = result['lon']
  end
end

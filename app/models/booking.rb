class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user
  validates :start_date_cannot_be_taken
  validates :end_date_cannot_be_taken
  validates :start_date_cannot_be_in_the_past
  validates :end_date_cannot_be_in_the_past
  validates :start_date_should_be_before_end_date

  private

  def start_date_cannot_be_taken
    space_existing_bookings = space.bookings
    arrival_date_in_form = start_date
    space_existing_bookings.each do |booking|
      if arrival_date_in_form.between?(booking.start_date, booking.end_date)
        errors.add(:start_date, "Arrival date is not available :( ")
      end
    end
  end

  def end_date_cannot_be_taken
    space_existing_bookings = space.bookings
    departure_date_in_form = end_date
    space_existing_bookings.each do |booking|
      if departure_date_in_form.between?(booking.start_date, booking.end_date)
        errors.add(:end_date, "Departure date is not available :( ")
      end
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "Arrival date can't be in the past!")
    end
  end

  def end_date_cannot_be_in_the_past
    if end_date < Date.today
      errors.add(:end_date, "Departure date can't be in the past!")
    end
  end

  def start_date_should_be_before_end_date
    if start_date > end_date
      errors.add(:start_date, "Arrival date should be before departure date!")
    end
  end

end

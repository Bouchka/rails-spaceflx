class Booking < ApplicationRecord
  belongs_to :space
  belongs_to :user
  validate :start_date_cannot_be_taken
  validate :end_date_cannot_be_taken
  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_in_the_past
  validate :start_date_should_be_before_end_date

  private

  def start_date_cannot_be_taken
    space_existing_bookings = space.bookings
    arrival_date_in_form = start_date
    space_existing_bookings.each do |booking|
      if arrival_date_in_form.between?(booking.start_date, booking.end_date)
        errors.add(:start_date, "is not available :( ")
      end
    end
  end

  def end_date_cannot_be_taken
    space_existing_bookings = space.bookings
    departure_date_in_form = end_date
    space_existing_bookings.each do |booking|
      if departure_date_in_form.between?(booking.start_date, booking.end_date)
        errors.add(:end_date, "is not available :( ")
      end
    end
  end

  def start_date_cannot_be_in_the_past
    if start_date < Date.today
      errors.add(:start_date, "can't be in the past!")
    end
  end

  def end_date_cannot_be_in_the_past
    if end_date < Date.today
      errors.add(:end_date, "can't be in the past!")
    end
  end

  def start_date_should_be_before_end_date
    if start_date > end_date
      errors.add(:start_date, "should be before departure date!")
    end
  end
end

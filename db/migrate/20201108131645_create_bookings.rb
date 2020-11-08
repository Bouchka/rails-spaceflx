class CreateBookings < ActiveRecord::Migration[6.0]
  def change
    create_table :bookings do |t|
      t.date :start_date
      t.date :end_date
      t.float :price_per_day
      t.string :status
      t.references :space
      t.references :user

      t.timestamps
    end
  end
end

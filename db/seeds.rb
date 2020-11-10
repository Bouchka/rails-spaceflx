# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'open-uri'

puts "Cleaning the DB"
Booking.destroy_all
Space.destroy_all
User.destroy_all
puts "DB sweeped clean"

puts "Creating Users..."
10.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  user = User.new(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}@gmail.com"
    )
  user.save
  # Create spaces for this user

  puts "Creating spaces for #{user.first_name} #{user.last_name}..."
  rand(10).times do
    name = Faker::Space.star_cluster
    space = Space.new(
      name: name,
      description: Faker::Lorem.paragraph,
      capacity: rand(500),
      price_per_day: rand(5000),
      address: Faker::Address.full_address,
      owner: user
      )
    file = URI.open('https://source.unsplash.com/user/sidekix')
    space.photo.attach(io: file, filename: "#{name}.jpg", content_type: 'image/jpg' )
    space.save
  end
end

puts "#{User.count} users created."
puts "#{Space.count} spaces created."

puts "Creating bookings..."

25.times do
  space = Space.all.sample
  user = User.all.sample
  unless user.id == space.owner_id
    start_date = rand(3.months).from_now
    booking = Booking.new(
      start_date: start_date,
      end_date: start_date + rand(10).days,
      price_per_day: space.price_per_day,
      status: 'booked',
      space: space,
      user: user
      )
    booking.save
  end
end

puts "#{Booking.count} bookings created."
puts "Seeding completed."

puts "Creating Bookings..."

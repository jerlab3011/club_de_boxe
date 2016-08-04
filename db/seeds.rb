# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(first_name: "Jérôme", last_name: "Labonté", email: "jeromelabonte@hotmail.com", 
phone: "438-820-8789", address: "8423 rue Berri", postal_code:"H2P 2G3", 
birth_date: "30-11-1984", gender: "M", 
password:"foobar", password_confirmation:"foobar", admin: true)

99.times do |n|
  first_name  = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = "example-#{n+1}@railstutorial.org"
  phone = "514-123-1234"
  password = "password"
  date = Faker::Date.between(70.year.ago, 6.years.ago)
  address = Faker::Address.street_address
  
  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               phone: phone,
               address: address,
               postal_code: "H0H 0H0",
               birth_date: date,
               gender: "M",
               password:              password,
               password_confirmation: password)
end
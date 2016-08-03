# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "Jérôme Labonté", email: "jeromelabonte@hotmail.com", phone: "438-820-8789", adress: "8423 rue Berri", postal_code:"H2P 2G3", birth_date: "30-11-1984", gender: "M", password:"foobar", password_confirmation:"foobar")
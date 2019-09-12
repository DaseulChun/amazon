# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Product.destroy_all
Review.destroy_all
User.destroy_all

NUM_PRODUCTS = 1000
NUM_USERS = 10
PASSWORD = "supersecret"

super_user = User.create(
  first_name: "Daseul",
  last_name: "Chun",
  email: "daseul.chun@gmail.com",
  password: PASSWORD,
  is_admin: true
)

NUM_USERS.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name

  User.create(
    first_name: first_name,
    last_name: last_name,
    email: "#{first_name.downcase}.#{last_name.downcase}@example.com",
    password: PASSWORD
  )
end

users = User.all

NUM_PRODUCTS.times do
  created_at = Faker::Date.backward(days: 365 * 5)
  p = Product.create(
    title: Faker::Cannabis.strain,
    description: Faker::Cannabis.health_benefit,
    price: rand(100_000),
    created_at: created_at,
    updated_at: created_at,
    user: users.sample
  )

  if p.valid?
    p.reviews = rand(0..10).times.map do
      Review.new(
        body: Faker::GreekPhilosophers.quote, 
        rating: rand(1..5),
        user: users.sample
      )
    end
  end
end

products = Product.all
reviews = Review.all

puts Cowsay.say("Generated #{products.count} products", :frogs)
puts Cowsay.say("Generated #{reviews.count} reviews", :stegosaurus)
puts Cowsay.say("Generated #{users.count} users", :tux)
puts "Login with #{super_user.email} and password: #{PASSWORD}"
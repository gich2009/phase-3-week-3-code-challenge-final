puts "🌱 Seeding data..."

10.times do
  User.create(name: Faker::Name.name)
end

10.times do
  Product.create(name: Faker::Commerce.product_name)
end

users = User.all
products = Product.all

100.times do
  Review.create(
    user: users.sample,
    product: products.sample,
    star_rating: rand(1..5),
    comment: Faker::Lorem.sentence(word_count: 15)
  )
end

puts "🌱 Done seeding!"

User.create!(name: "Le Cao Dat", email: "lecaodat1909@gmail.com",
  password: "123456", password_confirmation: "123456", is_admin: true)

9.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@gmail.com"
  password = "password"
  User.create!(name: name, email: email, password: password, password_confirmation: password)
end

Category.create!(name: "Foods", parent_id: 0)
Category.create!(name: "Drinks", parent_id: 0)
food = Category.find_by name: "Foods"
drink = Category.find_by name: "Drinks"

3.times do |n|
  name = Faker::Name.name
  parent_id = food.id
  Category.create!(name: name, parent_id: parent_id)
end

3.times do |n|
  name = Faker::Name.name
  parent_id = drink.id
  Category.create!(name: name, parent_id: parent_id)
end

categories = Category.all
10.times do
  price = 10000
  quality = 10
  categories.each{|category| category.products.create!(name: Faker::Name.name, detail: Faker::Name.name, price: price, quality: quality)}
end



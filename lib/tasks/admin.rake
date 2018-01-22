namespace :admin do
  desc "Init admin account"
  task admin_account: :environment do
    User.create!(name: "Administrator", email: "admin@gmail.com",
      password: "123456", password_confirmation: "123456", is_admin: true,
      activated: true, activated_at: Time.zone.now)
  end

  desc "Init root categories"
  task root_categories: :environment do
    Category.create!(name: "Foods", parent_id: 0)
    Category.create!(name: "Drinks", parent_id: 0)
  end
end

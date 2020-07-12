User.create!(
  name: "Admin User",
  email: "admin@admin.com",
  password: "passwordAdmin!",
  password_confirmation: "passwordAdmin!",
  admin: true,
)

case Rails.env
when "development"
  99.times do |n|
    name = Faker::Name.name
    email = "example+#{n+1}@dtreasury.org"
    password = "password"
    User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password,
      admin: false,
    )
  end
  Device.create!(
    tag: "A01",
    category: "Phone",
    make: "Apple",
    model: "iPhone XS",
    color: "Black",
    memory: 256,
    os: "iOS 13.1"
  )
  Device.create!(
    tag: "S01",
    category: "Phone",
    make: "Samsung",
    model: "Galaxy S10",
    color: "Blue",
    memory: 128,
    os: "Android 8"
  )
end
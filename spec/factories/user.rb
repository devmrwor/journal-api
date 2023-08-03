FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { "password" }
    username { Faker::Internet.username }
  end
end

FactoryBot.define do
  factory :post do
    title { Faker::Lorem.sentence }
    content { Faker::Lorem.paragraph }
    label {["idea", "fun", "work", "life"].sample}
    created_at { Faker::Time.between(from: 1.year.ago, to: Time.zone.now, format: :default) }
    updated_at { Faker::Time.between(from: created_at, to: Time.zone.now, format: :default) }
  end
end

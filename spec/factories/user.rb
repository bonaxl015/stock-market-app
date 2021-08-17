FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
    username { Faker::Lorem.unique.characters(number: 6) }
    user_type { Faker::Lorem.characters(number: 5) }
  end
end
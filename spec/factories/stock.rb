FactoryBot.define do
  factory :stock do
    name { Faker::Company.unique.name }
    unit_price { Faker::Number.number(digits: 5) }
    shares { Faker::Number.number(digits: 6) }
    association :user
  end
end

FactoryBot.define do
  factory :order do
    name { Faker::Company.unique.name }
    unit_price { Faker::Number.number(digits: 5) }
    shares { Faker::Number.number(digits: 6) }
    association :user
    association :stock
  end
end

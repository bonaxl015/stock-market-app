FactoryBot.define do
  factory :order do
    name { Faker::Company.name }
    unit_price { Faker::Number.number(digits: 5) }
    shares { Faker::Number.number(digits: 6) }
    association :user
    association :stock

    trait :invalid_attributes do
      name { nil }
      unit_price { nil }
      shares { nil }
      association :user
      association :stock
    end

    trait :new_attributes do
      name { Faker::Company.name }
      unit_price { Faker::Number.number(digits: 4) }
      shares { Faker::Number.number(digits: 5) }
      association :user
      association :stock
    end
  end
end

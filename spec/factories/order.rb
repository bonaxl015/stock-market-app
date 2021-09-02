FactoryBot.define do
  factory :order do
    name { Faker::Company.name }
    unit_price { Faker::Number.between(from: 1, to: 10) }
    shares { Faker::Number.between(from: 1, to: 10) }
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
      unit_price { Faker::Number.between(from: 1, to: 10) }
      shares { Faker::Number.between(from: 1, to: 10) }
      association :user
      association :stock
    end
  end
end

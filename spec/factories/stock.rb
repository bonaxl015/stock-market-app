FactoryBot.define do
  factory :stock do
    name { Faker::Company.unique.name }
    unit_price { Faker::Number.between(from: 10, to: 99) }
    shares { Faker::Number.number(digits: 6) }
    association :user

    trait :invalid_attributes do
      name { nil }
      unit_price { nil }
      shares { nil }
      association :user
    end

    trait :new_attributes do
      name { Faker::Company.unique.name }
      unit_price { Faker::Number.number(digits: 4) }
      shares { Faker::Number.number(digits: 5) }
      association :user
    end
  end
end

FactoryBot.define do
  factory :item do
    name { Faker::Appliance.brand }
    description { Faker::Appliance.equipment }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    # merchant { nil }
    merchant
  end
end

FactoryBot.define do
  factory :invoice_item do
    # item { nil }
    # invoice { nil }
    quantity { Faker::Number.within(range: 1..100) }
    unit_price { Faker::Number.decimal(l_digits: 2) }
    item
    invoice
  end
end

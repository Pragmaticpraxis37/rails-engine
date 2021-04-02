FactoryBot.define do
  factory :transaction do
    # invoice { nil }
    credit_card_number { Faker::Business.credit_card_number }
    credit_card_expiration { Faker::Business.credit_card_expiry_date }
    result { "success" }
    invoice
  end
end

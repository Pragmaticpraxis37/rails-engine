FactoryBot.define do
  factory :invoice do
    # customer { nil }
    # merchant { nil }
    status { "shipped" }
    customer
    merchant
  end
end

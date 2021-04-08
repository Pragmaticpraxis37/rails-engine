class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer

  attribute :revenue do |merchant|
    merchant.most_revenue_one_merchant
  end
end

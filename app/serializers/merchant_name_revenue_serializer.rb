class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue

  attribute :name do |merchant|
    attr = Merchant.find(merchant.id)
    attr.name
  end
end

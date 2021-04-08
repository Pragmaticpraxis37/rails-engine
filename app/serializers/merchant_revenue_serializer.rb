class MerchantRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :id, :revenue

  attribute :id do |object|
    require "pry"; binding.pry
  end

end


# attr = Merchant.find(merchant.id)
# attr.name

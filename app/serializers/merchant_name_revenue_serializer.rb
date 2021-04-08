class MerchantNameRevenueSerializer
  include FastJsonapi::ObjectSerializer
  attributes :revenue

  attribute :name do |merchant|
    attr = Merchant.find(merchant.id)
    attr.name
  end

end


#
# {
#   "data": [
#     {
#       "id": "1",
#       "type": "merchant_name_revenue",
#       "attributes": {
#         "name": "Turing School",
#         "revenue": 512.256128
#       }

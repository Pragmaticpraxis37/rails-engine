class ItemsSoldSerializer
  include FastJsonapi::ObjectSerializer
  attributes :count

  attribute :name do |merchant|
    attr = Merchant.find(merchant.id)
    attr.name
  end
end

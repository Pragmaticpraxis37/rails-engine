class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  has_many :transactions, through: :invoices

  def self.obtain_merchants(per_page, page)
    limit(per_page).offset(self.offset_count(per_page, page))
  end

  def self.offset_count(per_page, page)
    if page.to_i <= 0 then page = 1 end
    unless page.to_i == 1
      (page.to_i - 1) * per_page
    end
  end

  def self.obtain_one_merchant(id)
    find(id)
  end

  def self.find_merchant(name)
    find_by("name ILIKE ?", "%#{name.downcase}%")
  end

  def self.most_revenue(merchants)
    joins(:transactions)
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .group(:id)
    .order("revenue desc")
    .limit(merchants)
  end

  def self.most_items(merchants)
    joins(:transactions)
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .select("merchants.id, sum(invoice_items.quantity) AS count")
    .group(:id)
    .order("count desc")
    .limit(merchants)
  end

  def most_revenue_one_merchant
    transactions
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .pluck("sum(invoice_items.unit_price * invoice_items.quantity) AS total")
    .first
  end
end


# Merchant.joins(:transactions)
# .where("transactions.result = ?", "success")
# .where("invoices.status = ?", "shipped")
# .select("merchants.id, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
# .group("merchants.id")
# .order("revenue desc")

# def self.find_all_merchants(name)
#   require "pry"; binding.pry
# find_by("name ILIKE ?", "%#{name.downcase}%")
# end



# Merchant.joins(:transactions).where("transactions.result = ?", "success").where("invoices.status = ?", "shipped").select("merchants.id, sum(invoice_items.quantity) AS total").group(:id).limit(5)

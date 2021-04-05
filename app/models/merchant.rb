class Merchant < ApplicationRecord
  has_many :items
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

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
end

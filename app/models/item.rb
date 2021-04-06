class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates_associated :merchant
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices


  def self.obtain_items(per_page, page)
    limit(per_page).offset(self.offset_count(per_page, page))
  end

  def self.offset_count(per_page, page)
    if page.to_i <= 0 then page = 1 end
    unless page.to_i == 1
      (page.to_i - 1) * per_page
    end
  end

  def self.obtain_one_item(id)
    find(id)
  end

  def delete_invoice
    invoices.joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
  end
end

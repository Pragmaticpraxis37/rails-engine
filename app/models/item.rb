class Item < ApplicationRecord
  validates :name, :description, :unit_price, :merchant_id, presence: true
  validates_associated :merchant
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices


  def self.obtain_items(per_page, page)
    offset(self.offset_count(per_page, page)).limit(per_page)
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

  def self.find_items(name)
    where("name ILIKE ? or description LIKE ?", "%#{name}%", "%#{name}%")
    .order(:name)
  end

  def self.min_price(min_price)
    min_price = min_price.to_f
    Item.where("unit_price >= ?", min_price).order(:name)
  end

  def self.max_price(max_price)
    max_price = max_price.to_f
    Item.where("unit_price <= ?", max_price).order(:name)
  end

  def self.price_range(min_price, max_price)
    min_price = min_price.to_f
    max_price = max_price.to_f
    Item.where("unit_price >= ? and unit_price <= ?", min_price, max_price).order(:name)
  end

  def self.most_revenue(quantity=10)
    joins(:transactions)
    .where("transactions.result = ?", "success")
    .where("invoices.status = ?", "shipped")
    .select("items.id, sum(invoice_items.unit_price * invoice_items.quantity) AS revenue")
    .group(:id)
    .order("revenue desc")
    .limit(quantity)
  end

  def delete_invoice
    invoices.joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
  end
end

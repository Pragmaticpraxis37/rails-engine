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

  def self.find_item(name)
    where("name ILIKE ? or description LIKE ?", "%#{name}%", "%#{name}%")
    .order(:name).first
  end

  def self.min_price(min_price)
    min_price = min_price.to_f
    Item.where("unit_price <= ?", min_price).order(:name).limit(1).first
  end




  def delete_invoice
    invoices.joins(:items)
    .select("invoices.*, count(items.*)")
    .group("invoices.id")
    .having("count(items.*) = 1").pluck(:id)
  end
end

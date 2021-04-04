class Item < ApplicationRecord
  belongs_to :merchant

  def self.obtain_items(per_page, page)
    limit(per_page).offset(self.offset_count(per_page, page))
  end

  def self.offset_count(per_page, page)
    if page.to_i <= 0 then page = 1 end
    unless page.to_i == 1
      (page.to_i - 1) * per_page
    end
  end
end

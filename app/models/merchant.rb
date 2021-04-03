class Merchant < ApplicationRecord
  def self.obtain_merchants(per_page, page)
    limit(per_page).offset(self.offset_count(per_page, page))
  end

  def self.offset_count(per_page, page)
    unless page == 1
      (page - 1) * per_page
    end
  end
end

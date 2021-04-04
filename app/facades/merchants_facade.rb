class MerchantsFacade
  def self.merchants_index(params)
    # require "pry"; binding.pry
    if params[:per_page].nil? == true && params[:page].nil? == true
      Merchant.obtain_merchants(20, 1)
    elsif params[:per_page].nil? == true
      Merchant.obtain_merchants(20, params[:page])
    elsif params[:page].nil? == true
      Merchant.obtain_merchants(params[:per_page], 1)
    else
      Merchant.obtain_merchants(params[:per_page].to_i, params[:page].to_i)
    end
  end

  def self.merchants_show(id)
    Merchant.obtain_one_merchant(id)
  end
end

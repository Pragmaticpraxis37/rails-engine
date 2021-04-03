class MerchantsFacade
  def self.merchants_index(params)
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
end


# all_merchants = MerchantsFacade.all_merchants(params[:per_page].to_i, params[:page].to_i)

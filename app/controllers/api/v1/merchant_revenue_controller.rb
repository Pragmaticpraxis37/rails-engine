class Api::V1::MerchantRevenueController < ApplicationController

  def most_revenue
    # require "pry"; binding.pry
    merchants = Merchant.most_revenue(params[:quantity])
    @serial = merchants
    render json: MerchantNameRevenueSerializer.new(@serial)
  end

  def most_revenue_one_merchant
    merchant = Merchant.find(params[:id])
    @serial = merchant.most_revenue_one_merchant
    require "pry"; binding.pry
    render json: MerchantRevenueSerializer.new(@serial)
  end

end

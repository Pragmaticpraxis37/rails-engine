class Api::V1::MerchantRevenueController < ApplicationController

  def most_revenue
    if !params[:quantity].present? || params[:quantity].to_i < 1
      render json: {error: "Please provide a quantity"}, status: 400
    else
      merchants = Merchant.most_revenue(params[:quantity])
      @serial = merchants
      render json: MerchantNameRevenueSerializer.new(@serial)
    end
  end

  def most_revenue_one_merchant
    @merchant = Merchant.find(params[:id])
    @serial = MerchantRevenueSerializer.new(@merchant)
    render json: @serial
  end

end





  # def most_revenue
  #   merchants = Merchant.most_revenue(params[:quantity])
  #   @serial = merchants
  #   render json: MerchantNameRevenueSerializer.new(@serial)
  # end

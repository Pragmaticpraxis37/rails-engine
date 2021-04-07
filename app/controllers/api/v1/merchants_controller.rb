class Api::V1::MerchantsController < ApplicationController

  def index
    merchants = MerchantsFacade.merchants_index(params)
    render json: MerchantSerializer.new(merchants)
  end

  def show
    merchant = MerchantsFacade.merchants_show(params[:id].to_i)
    render json: MerchantSerializer.new(merchant)
  end
end

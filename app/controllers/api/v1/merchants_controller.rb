module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        merchants = MerchantsFacade.merchants_index(params)
        render json: MerchantSerializer.new(merchants)
      end

      def show
        merchant = MerchantsFacade.merchants_show(params[:id].to_i)
        render json: MerchantSerializer.new(merchant)
      end
    end
  end
end

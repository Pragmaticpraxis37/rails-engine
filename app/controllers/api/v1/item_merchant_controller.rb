module Api
  module V1
    class ItemMerchantController < ApplicationController
      def show
        item = Item.find(params[:id]) if Item.find(params[:id])
        merchant = item.merchant
        render json: MerchantSerializer.new(merchant)
      end
    end
  end
end

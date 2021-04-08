module Api
  module V1
    class MerchantItemController < ApplicationController
      def index
        merchant = Merchant.find(params[:id])
        items = merchant.items
        render json: ItemSerializer.new(items)
      end
    end
  end
end

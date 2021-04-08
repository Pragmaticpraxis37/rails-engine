module Api
  module V1
    class MerchantMostItemsController < ApplicationController

      def most_items
        if !params[:quantity].present? || params[:quantity].to_i < 1
          render json: {error: "Please provide a quantity"}, status: 400
        else
          merchants = Merchant.most_items(params[:quantity])
          @serial = merchants
          render json: ItemsSoldSerializer.new(@serial)
        end
      end
    end
  end
end


# merchants = Merchant.most_revenue(params[:quantity])
# @serial = merchants
# render json: MerchantNameRevenueSerializer.new(@serial)







  # def most_items
  #   merchants = Merchant.most_items(params[:quantity])
  #   @serial = merchants
  #   render json: ItemsSoldSerializer.new(@serial)
  # end

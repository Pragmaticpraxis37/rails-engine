module Api
  module V1
    class SearchController < ApplicationController

      def find_merchant_by_name
        merchant = Merchant.find_merchant(params[:name])
        if merchant.nil?
          render json: {data: { }}, status: 200
        else
          render json: MerchantSerializer.new(merchant), status: 200
        end
      end

      def find_item_by_name_or_description_or_price
        # require "pry"; binding.pry
        if (params[:name] && params[:min_price]) || (params[:name] && params[:max_price])
          render json: {data: { }}, status: 400
          # render json: {data: {}, error: ‘error’}
        elsif params[:name]
          find_item_by_name_or_description(params[:name])
        elsif params[:min_price] && params[:max_price]
          find_item_in_price_range(params[:min_price], params[:max_price])
        elsif params[:min_price]
          find_item_by_min_price(params[:min_price])
        else
          find_item_by_max_price(params[:max_price])
        end
      end

      def find_item_by_name_or_description(name)
        item = Item.find_item(name)
        if item.nil?
          render json: {data: { }}, status: 200
        else
          render json: ItemSerializer.new(item), status: 200
        end
      end

      def find_item_by_min_price(min_price)
        min_price = Item.min_price(min_price)
        render json: ItemSerializer.new(min_price), status: 200
      end
    end
  end
end





# def find_item_by_name_or_description_or_price
#   item = Item.find_item(params[:name])
#   if item.nil?
#     render json: {data: { }}, status: 200
#   else
#     render json: ItemSerializer.new(item), status: 200
#   end
# end

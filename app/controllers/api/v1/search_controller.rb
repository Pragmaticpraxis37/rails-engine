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

      # def find_all_merchants_by_name
      #   merchants = Merchant.find_all_merchants(params[:name])
      #   if merchants.nil?
      #     render json: {data: { }}, status: 200
      #   else
      #     render json: MerchantSerializer.new(merchants), status: 200
      #   end
      # end



      def find_all_items_by_name_or_description_or_price
        # params[:name].present? ? name = params[:name] : render json: {}
        # min_price = params[:min_price]  params[:min_price]present?
        # max_price = params[:max_price] if params[:max_price]present?
        # params[:name] ? params : false
        # params_check(params)
        # require "pry"; binding.pry
        # if params[:name].empty? || params[:min_price].empty? || params[:max_price].empty?
        #   render json: {data: { error: "Your search could not be completed because you did not pass in a value to the query parameter"}}, status: 400
        # require "pry"; binding.pry
        if !params[:name].present? && !params[:min_price].present? && !params[:max_price].present?
          render json: {data: { error: "Your search could not be completed because you did not pass in a query parameter"}}, status: 400
        elsif (params[:name] && params[:min_price]) || (params[:name] && params[:max_price])
          render json: {data: { error: 'You cannot have both a name and price query parameter in one search' }}, status: 400
        elsif params[:name]
          find_all_items_by_name_or_description(params[:name])
        elsif params[:min_price] && params[:max_price]
          find_item_in_price_range(params[:min_price], params[:max_price])
        elsif params[:min_price]
          find_item_by_min_price(params[:min_price])
        elsif params[:max_price]
          find_item_by_max_price(params[:max_price])
        # elsif
        #   require "pry"; binding.pry
        end
      end

      # def params_check(params)
      #   if params[:name].nil? && params[:min_price].nil? && params[:max_price].nil?
      #     render json: {data: { error: "Your search could not be completed because you did not pass in a query parameter"}}, status: 400
      #   end
        # require "pry"; binding.pry
      # end


      def find_all_items_by_name_or_description(name)
        items = Item.find_items(name)
        if items.empty?
          render json: {data: [ ]}, status: 404
        else
          render json: ItemSerializer.new(items), status: 200
        end
      end

      def find_item_by_min_price(min_price)
        min_price = Item.min_price(min_price)
        render json: ItemSerializer.new(min_price), status: 200
      end

      def find_item_by_max_price(max_price)
        max_price = Item.max_price(max_price)
        render json: ItemSerializer.new(max_price), status: 200
      end

      def find_item_in_price_range(min_price, max_price)
        price_range = Item.price_range(min_price, max_price)
        render json: ItemSerializer.new(price_range), status: 200
      end
    end
  end
end




# params_check(params)
# require "pry"; binding.pry
# if (params[:name] && params[:min_price]) || (params[:name] && params[:max_price])
#   render json: {data: { error: 'You cannot have both a name and price query parameter in one search' }}, status: 400
# elsif params[:name]
#   find_item_by_name_or_description(params[:name])
# elsif params[:min_price] && params[:max_price]
#   find_item_in_price_range(params[:min_price], params[:max_price])
# elsif params[:min_price]
#   find_item_by_min_price(params[:min_price])
# elsif params[:max_price]
#   find_item_by_max_price(params[:max_price])
# elsif params[:name].nil? && params[:min_price].nil? && params[:max_price].nil?
#   render json: {data: { error: "Your search could not be completed because you did not pass in a query parameter"}}, status: 400
# end




# def find_item_by_name_or_description_or_price
#   item = Item.find_item(params[:name])
#   if item.nil?
#     render json: {data: { }}, status: 200
#   else
#     render json: ItemSerializer.new(item), status: 200
#   end
# end

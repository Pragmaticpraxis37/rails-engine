module Api
  module V1
    class ItemRevenueController < ApplicationController
      def most_revenue
        if params[:quantity].to_i < 1
          render json: {error: "Please provide a quantity"}, status: 400
        else
          # require "pry"; binding.pry
          items = Item.most_revenue(params[:quantity])
          @serial = items
          render json: ItemRevenueSerializer.new(@serial)
        end
      end
    end
  end
end

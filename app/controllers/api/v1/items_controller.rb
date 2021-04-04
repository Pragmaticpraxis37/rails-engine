module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = ItemsFacade.items_index(params)
        render json: ItemSerializer.new(items)
      end

      def show
        item = ItemsFacade.items_show(params[:id].to_i)
        render json: ItemSerializer.new(item)
      end
    end
  end
end

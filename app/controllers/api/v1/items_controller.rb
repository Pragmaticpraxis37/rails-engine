module Api
  module V1
    class ItemsController < ApplicationController
      def index
        items = ItemsFacade.items_index(params)
        render json: ItemSerializer.new(items)
      end
    end
  end
end

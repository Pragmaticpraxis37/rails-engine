module Api
  module V1
    class ItemsController < ApplicationController
      def index
        # require "pry"; binding.pry
        items = ItemsFacade.items_index(params)
        # require "pry"; binding.pry
        render json: ItemSerializer.new(items)
      end
    end
  end
end

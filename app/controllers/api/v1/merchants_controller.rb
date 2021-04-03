module Api
  module V1
    class MerchantsController < ApplicationController

        def index
          merchants = MerchantsFacade.merchants_index(params)
          render json: MerchantSerializer.new(merchants)
          # require "pry"; binding.pry
        end



    end
  end
end

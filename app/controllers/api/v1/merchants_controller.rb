module Api
  module V1
    class MerchantsController < ApplicationController

        def index
          if params[:per_page].nil? == true && params[:page].nil? == true
            all_merchants = MerchantsFacade.all_merchants(params[:per_page].to_i, params[:page].to_i)
          elsif params[:per_page].nil? == true
          end

        end



    end
  end
end

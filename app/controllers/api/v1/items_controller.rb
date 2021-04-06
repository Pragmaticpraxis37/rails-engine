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

      def create
        new_item = Item.create(item_params)
        render json: ItemSerializer.new(new_item)
      end

      def update
        updated_item = Item.update(item_params) if Merchant.find(params[:item][:merchant_id])
      end

      def destroy
        item = Item.find(params[:id])
        Invoice.destroy(item.delete_invoice)
        Item.destroy(params[:id])
      end

      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
  end
end

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
        if new_item.save
          render json: ItemSerializer.new(new_item), status: :created
        end
      end

      def update
        if (Item.find(params[:id]) && params[:item][:merchant_id].present? && Merchant.find(params[:item][:merchant_id])) || Item.find(params[:id])
          updated_item = Item.update(params[:id], item_params)
          render json: ItemSerializer.new(updated_item), status: :created
        end
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

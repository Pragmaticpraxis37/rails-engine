require 'rails_helper'

describe 'Item Destroy API' do
  before :each do
    @merchant_2 = create(:merchant)
    @item_2 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, merchant: @merchant_2)
    @invoice_item_1 = create(:invoice_item, item: @item_2, invoice: @invoice_1)

    # @merchant_2 = create(:merchant)
    # @item_2 = create(:item, merchant: @merchant_2)




    @item_3 = create(:item, merchant: @merchant_2)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_2)
    #
    # @item_4 = create(:item, merchant: @merchant_2)
    # @invoice_3 = create(:invoice, merchant: @merchant_2)
    # @invoice_item_4 = create(:invoice_item, item: @item_2, invoice: @invoice_3)
    # @invoice_item_5 = create(:invoice_item, item: @item_4, invoice: @invoice_3)
  end

  describe 'happy path' do
    it "removes a single item from the Item table" do

      # require "pry"; binding.pry

      delete api_v1_item_path(@item_2.id)

      deleted = Invoice.where(id: @invoice_1.id).first
      not_deleted = Invoice.find(@invoice_2.id)

      # require "pry"; binding.pry

      expect(deleted).to be_nil
      # (ActiveRecord::RecordNotFound)
      expect(not_deleted).to_not be_nil
    end
  end
end

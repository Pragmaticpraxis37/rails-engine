require 'rails_helper'

describe 'Item Destroy API' do
  before :each do
    @merchant_2 = create(:merchant)
    @item_2 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, merchant: @merchant_2)
    @invoice_item_1 = create(:invoice_item, item: @item_2, invoice: @invoice_1)

    @item_3 = create(:item, merchant: @merchant_2)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_3 = create(:invoice_item, item: @item_3, invoice: @invoice_2)

    @invoice_3 = create(:invoice, merchant: @merchant_2)
    @invoice_item_4 = create(:invoice_item, item: @item_2, invoice: @invoice_3)
  end

  describe 'happy path' do
    it "removes a single item from the Item table and an Invoice when it only
      contains the deleted item" do
      delete api_v1_item_path(@item_2.id)

      deleted_item = Item.where(id: @item_2.id).first
      deleted_invoice = Invoice.where(id: @invoice_1.id).first
      not_deleted = Invoice.find(@invoice_2.id)

      expect(deleted_item).to be_nil
      expect(deleted_invoice).to be_nil
      expect(not_deleted).to_not be_nil
    end

    it "removes a single item from the Item table" do
      delete api_v1_item_path(@item_2.id)

      deleted_item = Item.where(id: @item_2.id).first
      deleted_1 = Invoice.where(id: @invoice_1.id).first
      deleted_2 = Invoice.where(id: @invoice_3.id).first
      not_deleted = Invoice.find(@invoice_2.id)

      expect(deleted_item).to be_nil 
      expect(deleted_1).to be_nil
      expect(deleted_2).to be_nil
      expect(not_deleted).to_not be_nil
    end
  end
end

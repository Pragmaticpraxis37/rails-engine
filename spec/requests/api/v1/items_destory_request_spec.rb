require 'rails_helper'

describe 'Item Destroy API' do
  before :each do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_item_1 = create(:invoice_item, item: @item_1, invoice: @invoice_1)

    @merchant_2 = create(:merchant)
    @item_2 = create(:item, merchant: @merchant_2)
    @item_3 = create(:item, merchant: @merchant_2)
    @invoice_2 = create(:invoice, merchant: @merchant_2)
    @invoice_item_2 = create(:invoice_item, item: @item_2, invoice: @invoice_2)
    @invoice_item_1 = create(:invoice_item, item: @item_3, invoice: @invoice_2)
  end

  describe 'happy path' do
    it "removes a single item from the Item table" do

      delete api_v1_item_path(@item_1.id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to be_a(Hash)
    end
  end
end

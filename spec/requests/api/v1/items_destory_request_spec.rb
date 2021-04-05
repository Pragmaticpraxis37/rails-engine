require 'rails_helper'

describe 'Merchants Index API' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_2)
    @item_4 = create(:item, merchant: @merchant_2)
    @invoice_1 = create(:invoice, merchant: @merchant_1)
    @invoice_item_1 = create(:item, merchant: @merchant_1)
  end

  describe 'happy path' do
    it "sends a single item in an array called 'data'" do


      require "pry"; binding.pry

      get api_v1_item_path(@item_1.id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to be_a(Hash)
    end
  end
end

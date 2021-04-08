require 'rails_helper'

describe 'Item ID Shows Merchant Data API' do
  before :each do
    @merchant_2 = create(:merchant)
    @item_2 = create(:item, merchant: @merchant_2)
  end

  describe 'happy path' do
    it "shows a merchant data for a merchant associated with a particular item" do
      get api_v1_items_merchant_path(@item_2.id)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to be_a(Hash)
    end

    it 'sends a single merchant with attributes' do
      get api_v1_items_merchant_path(@item_2.id)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_an(String)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to be_a(String)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
    end

    it 'send a error message if the item does not exist and therefore no merchant exists' do
      get api_v1_merchant_path("1000000000")

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:error]).to eq("Resource not found")
    end
  end
end

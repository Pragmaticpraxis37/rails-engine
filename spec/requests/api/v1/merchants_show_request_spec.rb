require 'rails_helper'

describe 'Merchants Index API' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
  end

  describe 'happy path' do
    it "sends a single merchant in an array called 'data'" do
      get api_v1_merchant_path(@merchant_1.id)

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to be_a(Hash)
    end

    it 'sends a single merchant with attributes' do
      get api_v1_merchant_path(@merchant_2.id)

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

    it 'send a ' do
      get api_v1_merchant_path("1000000000")

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:error]).to eq("Couldn't find Merchant with 'id'=1000000000")
    end
  end
end

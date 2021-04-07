require 'rails_helper'

describe 'Search Shows One Merchant By Name' do
  before :each do
    @merchant_1 = create(:merchant, name: "Ring World")
    @merchant_2 = create(:merchant, name: "Turing")
  end

  describe 'happy path' do
    it "shows one merchant that matches a search term" do
      get api_v1_find_merchant_by_name_path params: {name: "#{@merchant_1.name}"}

      expect(response).to be_successful

      merchant = JSON.parse(response.body, symbolize_names: true)

      expect(merchant[:data]).to be_a(Hash)
      expect(merchant[:data]).to have_key(:id)
      expect(merchant[:data][:id]).to be_an(String)
      expect(merchant[:data]).to have_key(:type)
      expect(merchant[:data][:type]).to be_a(String)
      expect(merchant[:data]).to have_key(:attributes)
      expect(merchant[:data][:attributes]).to be_a(Hash)
      expect(merchant[:data][:attributes]).to have_key(:name)
      expect(merchant[:data][:attributes][:name]).to be_a(String)
      expect(merchant[:data][:attributes][:name]).to eq("Ring World")
    end
  end

  describe 'sad path' do
    it "shows one merchant that matches a search term" do
      get api_v1_find_merchant_by_name_path params: {name: "zipper"}

      expect(response).to be_successful

      not_found = JSON.parse(response.body, symbolize_names: true)

      expect(not_found[:data]).to eq({})
    end
  end
end

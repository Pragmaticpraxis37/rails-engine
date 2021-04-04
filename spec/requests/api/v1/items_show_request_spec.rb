require 'rails_helper'

describe 'Merchants Index API' do
  before :each do
    @item_1 = create(:item)
    @item_2 = create(:item)
  end

  describe 'happy path' do
    it "sends a single item in an array called 'data'" do
      get api_v1_item_path(@item_1.id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to be_a(Hash)
    end

    it 'sends a single item with attributes' do
      get api_v1_item_path(@item_2.id)

      expect(response).to be_successful

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:data]).to have_key(:id)
      expect(item[:data][:id]).to be_an(String)
      expect(item[:data]).to have_key(:type)
      expect(item[:data][:type]).to be_a(String)
      expect(item[:data][:type]).to eq('item')
      expect(item[:data]).to have_key(:attributes)
      expect(item[:data][:attributes]).to be_a(Hash)
      expect(item[:data][:attributes]).to have_key(:name)
      expect(item[:data][:attributes][:name]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:description)
      expect(item[:data][:attributes][:description]).to be_a(String)
      expect(item[:data][:attributes]).to have_key(:unit_price)
      expect(item[:data][:attributes][:unit_price]).to be_a(Float)
      expect(item[:data][:attributes]).to have_key(:merchant_id)
      expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  describe 'sad path' do
    it 'sends an error message when no item with the id in the query param exists' do
      get api_v1_item_path("1000000000")

      item = JSON.parse(response.body, symbolize_names: true)

      expect(item[:error]).to eq("Couldn't find Item with 'id'=1000000000")
    end
  end
end

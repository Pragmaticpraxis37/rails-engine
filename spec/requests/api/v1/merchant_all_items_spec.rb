require 'rails_helper'

describe 'Merchants All Items' do
  before :each do
    @merchant_1 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)
  end

  describe 'happy path' do
    it 'sends a list of all items associated with a particular merchant' do
      get api_v1_merchant_items_path(@merchant_1.id)

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data][0]).to have_key(:id)
      expect(items[:data][0][:id]).to be_an(String)
      expect(items[:data][0]).to have_key(:type)
      expect(items[:data][0][:type]).to be_a(String)
      expect(items[:data][0][:type]).to eq('item')
      expect(items[:data][0]).to have_key(:attributes)
      expect(items[:data][0][:attributes]).to be_a(Hash)
      expect(items[:data][0][:attributes]).to have_key(:name)
      expect(items[:data][0][:attributes][:name]).to be_a(String)
      expect(items[:data][0][:attributes]).to have_key(:description)
      expect(items[:data][0][:attributes][:description]).to be_a(String)
      expect(items[:data][0][:attributes]).to have_key(:unit_price)
      expect(items[:data][0][:attributes][:unit_price]).to be_a(Float)
      expect(items[:data][0][:attributes]).to have_key(:merchant_id)
      expect(items[:data][0][:attributes][:merchant_id]).to be_an(Integer)
      expect(items[:data][0][:attributes][:name]).to eq(@item_1.name)
      expect(items[:data][1][:attributes][:name]).to eq(@item_2.name)
      expect(items[:data][2][:attributes][:name]).to eq(@item_3.name)
      expect(items[:data][3][:attributes][:name]).to eq(@item_4.name)
      expect(items[:data].length).to eq(4)
    end
  end

  describe 'sad path' do
    it 'sends a 404 if the merchant does not exist' do
      get api_v1_merchant_items_path("1000000000")

      expect(response.status).to eq(404)
    end
  end 
end

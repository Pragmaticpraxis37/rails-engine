require 'rails_helper'

describe 'Search Shows One Item By Name and Description' do
  before :each do
    @item_1 = create(:item, unit_price: 5.00, name: "Ring World")
    @item_2 = create(:item, unit_price: 5.00, name: "Turing")
    @item_3 = create(:item, unit_price: 5.00, description: "ring")
    @item_4 = create(:item, unit_price: 5.00, description: "wood")

    @item_5 = create(:item, unit_price: 2.00)
    @item_6 = create(:item, unit_price: 4.00, name: "Alabad")
    @item_7 = create(:item, unit_price: 4.00, name: "Caddle")
    @item_8 = create(:item, unit_price: 8.00, name: "Figgle")
    @item_9 = create(:item, unit_price: 8.00, name: "Vodor")
  end

  describe 'happy path' do
    it "shows one item that matches a name" do
      get api_v1_find_item_by_name_or_description_or_price_path params: {name: "Ring"}

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

      expect(item[:data][:attributes][:name]).to eq("Ring World")
    end

    it "shows one item that matches a description" do
      get api_v1_find_item_by_name_or_description_or_price_path params: {name: "wood"}

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

      expect(item[:data][:attributes][:description]).to eq("wood")
    end

    it "shows one item that is the lowest price" do
      get api_v1_find_item_by_name_or_description_or_price_path params: {min_price: "4"}

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

      expect(item[:data][:attributes][:name]).to eq("Alabad")
    end
  end

  describe 'sad path' do
    it "shows one merchant that matches a search term" do
      get api_v1_find_item_by_name_or_description_or_price_path params: {name: "zipper"}

      expect(response).to be_successful

      not_found = JSON.parse(response.body, symbolize_names: true)

      expect(not_found[:data]).to eq({})
    end

    xit 'does not accept name and min_price for a single query' do
      get api_v1_find_item_by_name_or_description_or_price_path params: {name: "zipper", min_price: 20}

      expect(response.status).to eq(400)
    end

    xit 'does not accept name and max_price for a single query' do
      get api_v1_find_item_by_name_or_description_or_price_path params: {name: "zipper", max_price: 20}

      expect(response.status).to eq(400)
    end
  end
end

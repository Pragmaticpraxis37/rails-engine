require 'rails_helper'

describe 'Search Shows All Items By Name and Description and Values' do
  before :each do
    @item_1 = create(:item, unit_price: 5.00, name: "Ring World")
    @item_2 = create(:item, unit_price: 5.00, name: "Turing")
    @item_3 = create(:item, unit_price: 5.00, name: "Zobble", description: "ring")
    @item_4 = create(:item, unit_price: 5.00, name: "Toble", description: "wood")

    @item_5 = create(:item, unit_price: 2.00, name: "Folore")
    @item_6 = create(:item, unit_price: 4.00, name: "Alabad")
    @item_7 = create(:item, unit_price: 4.00, name: "Caddle")
    @item_8 = create(:item, unit_price: 8.00, name: "Figgle")
    @item_9 = create(:item, unit_price: 8.00, name: "Vodor")
    @item_10 = create(:item, unit_price: 10.00, name: "Delor")
  end

  describe 'happy path' do
    it "shows one item if there is only one match for the name" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "Vodor"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data][0]).to have_key(:id)
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
      expect(items[:data][0][:attributes][:name]).to eq("Vodor")
      expect(items[:data].length).to eq(1)
    end

    it "shows all items that match a name" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "Ring"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data][0][:attributes][:name]).to eq("Ring World")
      expect(items[:data][1][:attributes][:name]).to eq("Turing")
      expect(items[:data].length).to eq(2)
    end

    it "shows all items that match a description" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "lor"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data][0][:attributes][:name]).to eq("Delor")
      expect(items[:data][1][:attributes][:name]).to eq("Folore")
      expect(items[:data].length).to eq(2)
    end

    it "shows all items that are above a minimum query amount" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {min_price: "4"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      no_folore = items[:data].any? do |item|
        item[:attributes][:name] == "Folore"
      end

      expect(items[:data].count).to eq(9)
      expect(no_folore).to be(false)
    end

    it "shows all items that are below the maximum query amount" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {max_price: "8"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      no_delor = items[:data].any? do |item|
        item[:attributes][:name] == "Delor"
      end

      expect(items[:data].count).to eq(9)
      expect(no_delor).to be(false)
    end

    it "shows all items that are in the range between minimum and maximum" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {min_price: "4.00", max_price: "8"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      no_delor = items[:data].any? do |item|
        item[:attributes][:name] == "Delor"
      end

      no_folore = items[:data].any? do |item|
        item[:attributes][:name] == "Folore"
      end

      expect(items[:data].count).to eq(8)
      expect(no_delor).to be(false)
      expect(no_folore).to be(false)
    end
  end

  describe 'sad path' do
    it "shows an empty array when an item does not match a search term" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "zipper"}

      not_found = JSON.parse(response.body, symbolize_names: true)

      expect(not_found[:data]).to eq([])
    end

    it "shows an error message when a query parameter is not passed in" do
      get api_v1_find_all_items_by_name_or_description_or_price_path

      missing_parameter = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(missing_parameter[:data][:error]).to eq("Your search could not be completed because you did not pass in a query parameter")
    end

    it "shows an error message when a query parameter without a value is passed in" do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: ""}

      missing_parameter_value = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(missing_parameter_value[:data][:error]).to eq("Your search could not be completed because you did not pass in a query parameter")
    end

    it 'does not accept name and min_price for a single query' do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "zipper", min_price: 20}

      not_permitted = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(not_permitted[:data][:error]).to eq("You cannot have both a name and price query parameter in one search")
    end

    it 'does not accept name and max_price for a single query' do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "zipper", max_price: 20}

      not_permitted = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(not_permitted[:data][:error]).to eq("You cannot have both a name and price query parameter in one search")
    end

    it 'does not accept name, min_price, and max_price for a single query' do
      get api_v1_find_all_items_by_name_or_description_or_price_path params: {name: "zipper", min_price: 5, max_price: 20}

      not_permitted = JSON.parse(response.body, symbolize_names: true)

      expect(response.status).to eq(400)
      expect(not_permitted[:data][:error]).to eq("You cannot have both a name and price query parameter in one search")
    end
  end
end

require 'rails_helper'

describe 'Items Index API' do
  before :each do
    @items = create_list(:item, 100)
  end

  describe 'happy path' do
    it "sends a list of items in an array called 'data'" do
      get api_v1_items_path

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
    end


    it 'sends a list of items with attributes' do
      get api_v1_items_path

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      items[:data].each do |item|
        expect(item).to have_key(:id)
        expect(item[:id]).to be_an(String)
        expect(item).to have_key(:type)
        expect(item[:type]).to be_a(String)
        expect(item[:type]).to eq('item')
        expect(item).to have_key(:attributes)
        expect(item[:attributes]).to be_a(Hash)
        expect(item[:attributes]).to have_key(:name)
        expect(item[:attributes][:name]).to be_a(String)
        expect(item[:attributes]).to have_key(:description)
        expect(item[:attributes][:description]).to be_a(String)
        expect(item[:attributes]).to have_key(:unit_price)
        expect(item[:attributes][:unit_price]).to be_a(Float)
        expect(item[:attributes]).to have_key(:merchant_id)
        expect(item[:attributes][:merchant_id]).to be_an(Integer)
      end
    end

    it 'sends a list of items 20 and one page by default if no query params are specified' do
      get api_v1_items_path

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
    end

    it 'sends a list of 50 items if requested in per_page query param' do
      get api_v1_items_path, params: {per_page: "50", page: "1"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(50)
    end

    it 'sends a list of merchants 51-100 if per_page query param is 50 and
        page query param is 2' do
      get api_v1_items_path, params: {per_page: "50", page: "2"}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      id = @items[50].id

      expect(items[:data].count).to eq(50)

      items[:data].each do |item|
        expect(item[:id].to_i).to eq(id)
        id += 1
      end
    end

    it 'sends a list of all items if requested in per_page query param
        is as large as the number of items' do
      get api_v1_items_path, params: {per_page: 100, page: 1}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(100)
    end



    it 'sends a list of all items if requested in per_page query param
        is larger than the number of items' do
      get api_v1_items_path, params: {per_page: 101, page: 1}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(100)
    end

    it 'sends a data array if there is no return data for the query' do
      get api_v1_items_path, params: {per_page: 75, page: 3}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data]).to be_an(Array)
      expect(items[:data].count).to eq(0)
    end
  end

  describe 'sad path' do
    it 'defaults to page 1 if page query param is 0' do
      get api_v1_items_path, params: {page: 0}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
    end

    it 'defaults to page 1 if page query param is less than 1' do
      get api_v1_items_path, params: {page: -1}

      expect(response).to be_successful

      items = JSON.parse(response.body, symbolize_names: true)

      expect(items[:data].count).to eq(20)
    end
  end
end

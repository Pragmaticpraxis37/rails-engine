require 'rails_helper'

describe 'Merchants Index API' do
  before :each do
    @merchants = create_list(:merchant, 100)
  end

  describe 'happy path' do
    it "sends a list of merchants in an array called 'data'" do
      get api_v1_merchants_path

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data]).to be_an(Array)
    end

    it 'sends a list of merchants with attributes' do
      get api_v1_merchants_path

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      merchants[:data].each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant[:id]).to be_an(String)
        expect(merchant).to have_key(:type)
        expect(merchant[:type]).to be_a(String)
        expect(merchant).to have_key(:attributes)
        expect(merchant[:attributes]).to be_a(Hash)
        expect(merchant[:attributes]).to have_key(:name)
        expect(merchant[:attributes][:name]).to be_a(String)
      end
    end

    it 'sends a list of merchants 20 and one page by default if no query params are specified' do
      get api_v1_merchants_path

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
    end

    it 'sends a list of 50 merchants if requested in per_page query param' do
      get api_v1_merchants_path, params: {per_page: "50", page: "1"}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(50)
    end

    it 'sends a list of merchants 51-100 if per_page query param is 50 and
        page query param is 2' do
      get api_v1_merchants_path, params: {per_page: "50", page: "2"}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      id = @merchants[50].id

      expect(merchants[:data].count).to eq(50)

      merchants[:data].each do |merchant|
        expect(merchant[:id].to_i).to eq(id)
        id += 1
      end
    end

    it 'sends a list of all merchants if requested in per_page query param
        is as large as the number of merchants' do
      get api_v1_merchants_path, params: {per_page: 100, page: 1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(100)
    end

    it 'sends a list of all merchants if requested in per_page query param
        is larger than the number of merchants' do
      get api_v1_merchants_path, params: {per_page: 101, page: 1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(100)
    end

    it 'sends an data array if there is no return data for the query' do
      get api_v1_merchants_path, params: {per_page: 75, page: 3}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data]).to be_an(Array)
      expect(merchants[:data].count).to eq(0)
    end
  end

  describe 'sad path' do
    it 'defaults to page 1 if page query param is 0' do
      get api_v1_merchants_path, params: {page: 0}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
    end

    it 'defaults to page 1 if page query param is less than 1' do
      get api_v1_merchants_path, params: {page: -1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      expect(merchants[:data].count).to eq(20)
    end
  end
end

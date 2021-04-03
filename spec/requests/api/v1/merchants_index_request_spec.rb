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

    xit 'sends a list of merchants with attributes' do
      get api_v1_merchants_path

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      # Need to dig in farther into attributes

      merchants.each do |merchant|
        expect(merchant).to have_key(:id)
        expect(merchant).to be_an(Integer)

        expect(merchant).to have_key(:type)
        expect(merchant).to be_a(String)

        expect(merchant).to have_key(:attributes)
        expect(merchant).to be_a(String)
      end
    end

    xit 'sends a list of merchants 20 and one page by default if no query params are specified' do
      get api_v1_merchants_path

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      # Might need to open array more
      expect(merchants[:data].count).to eq(20)
    end

    xit 'sends a list of 50 merchants if requested in per_page query param' do
      get api_v1_merchants_path, params: {per_page: 50, page: 1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      # Might need to open array more
      expect(merchants[:data].count).to eq(50)
    end

    xit 'sends a list of merchants 51-100 if per_page query param is 50 and
        page query param is 2' do
      get api_v1_merchants_path, params: {per_page: 50, page: 2}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      count = 51

      merchants.each do |merchant|
        expect(merchant[:data][:id]).to eq(count)
        count += 1
      end
    end

    xit 'sends a list of all merchants if requested in per_page query param
        is as large as the number of merchants' do
      get api_v1_merchants_path, params: {per_page: 100, page: 1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      # Might need to open array more
      expect(merchants[:data].count).to eq(100)
    end

    xit 'sends a list of all merchants if requested in per_page query param
        is larger than the number of merchants' do
      get api_v1_merchants_path, params: {per_page: 101, page: 1}

      expect(response).to be_successful

      merchants = JSON.parse(response.body, symbolize_names: true)

      # Might need to open array more
      expect(merchants[:data].count).to eq(100)
    end
  end
end

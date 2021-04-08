require 'rails_helper'

describe 'Items Create API' do
  before :each do
    @merchant = create(:merchant)
  end

  describe 'happy path' do
    it 'can create a new item and save it to the Item database' do
      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        unit_price: 12.50,
        merchant_id: @merchant.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      expect(response).to be_successful

      created_item = Item.last

      expect(created_item.name).to eq(item_params[:name])
      expect(created_item.description).to eq(item_params[:description])
      expect(created_item.unit_price).to eq(item_params[:unit_price])
      expect(created_item.merchant_id).to eq(item_params[:merchant_id])
    end

    it 'can create a new item and save it to the Item database' do
      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        unit_price: 12.50,
        merchant_id: @merchant.id
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

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
    it 'only accepts a JSON body with the following fields: name, description,
        unit_price, and merchant_id' do

      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        unit_price: 12.50,
        merchant_id: @merchant.id,
        review: 'This is a great product'
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

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
      expect(item[:data]).to_not have_key(:review)
    end

    it 'will not create an Item without all of the following fields: name,
        description, unit_price, and merchant_id' do

      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)

      created_item = Item.last

      expect(created_item).to eq(nil)
    end
  end
end

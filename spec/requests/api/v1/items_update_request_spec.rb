require 'rails_helper'

describe 'Items Update API' do
  before :each do
    @merchant_1 = create(:merchant)
    @merchant_2 = create(:merchant)
    @item_1 = create(:item, merchant: @merchant_1)
  end

  describe 'happy path' do
    it "can update an existing item's name, description, or unit price and save
        the changes to the Item database" do

      id = @item_1.id
      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price
      previous_merchant_id = Item.last.merchant_id

      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        unit_price: 12.50,
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      patch api_v1_item_path(@item_1), headers: headers, params: JSON.generate(item: item_params)

      updated_item_json = JSON.parse(response.body, symbolize_names: true)

      updated_item = Item.find(@item_1.id)

      expect(response).to be_successful

      expect(updated_item.name).to_not eq(previous_name)
      expect(updated_item.description).to_not eq(previous_description)
      expect(updated_item.unit_price).to_not eq(previous_unit_price)

      expect(updated_item_json[:data]).to have_key(:id)
      expect(updated_item_json[:data][:id]).to be_an(String)
      expect(updated_item_json[:data]).to have_key(:type)
      expect(updated_item_json[:data][:type]).to be_a(String)
      expect(updated_item_json[:data][:type]).to eq('item')
      expect(updated_item_json[:data]).to have_key(:attributes)
      expect(updated_item_json[:data][:attributes]).to be_a(Hash)
      expect(updated_item_json[:data][:attributes]).to have_key(:name)
      expect(updated_item_json[:data][:attributes][:name]).to be_a(String)
      expect(updated_item_json[:data][:attributes]).to have_key(:description)
      expect(updated_item_json[:data][:attributes][:description]).to be_a(String)
      expect(updated_item_json[:data][:attributes]).to have_key(:unit_price)
      expect(updated_item_json[:data][:attributes][:unit_price]).to be_a(Float)
      expect(updated_item_json[:data][:attributes]).to have_key(:merchant_id)
      expect(updated_item_json[:data][:attributes][:merchant_id]).to be_an(Integer)
    end
  end

  describe 'sad path' do
    it 'will not allow an update to an item with a bad merchant id' do
      id = @item_1.id
      previous_name = Item.last.name
      previous_description = Item.last.description
      previous_unit_price = Item.last.unit_price
      previous_merchant_id = Item.last.merchant_id

      item_params = ({
        name: 'Wobbler',
        description: 'Wobbles',
        unit_price: 12.50,
        merchant_id: 100000000000
        })

      headers = {"CONTENT_TYPE" => "application/json"}

      patch api_v1_item_path(@item_1), headers: headers, params: JSON.generate(item: item_params)

      update_failed = JSON.parse(response.body, symbolize_names: true)

      expect(update_failed[:error]).to eq("Resource not found")
      expect(response.status).to eq(404)
    end
  end
end
#
#     it 'can create a new item and save it to the Item database' do
#       item_params = ({
#         name: 'Wobbler',
#         description: 'Wobbles',
#         unit_price: 12.50,
#         merchant_id: @merchant.id
#         })
#
#       headers = {"CONTENT_TYPE" => "application/json"}
#
#       post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
#
#       expect(response).to be_successful
#
#       item = JSON.parse(response.body, symbolize_names: true)
#
#       expect(item[:data]).to have_key(:id)
#       expect(item[:data][:id]).to be_an(String)
#       expect(item[:data]).to have_key(:type)
#       expect(item[:data][:type]).to be_a(String)
#       expect(item[:data][:type]).to eq('item')
#       expect(item[:data]).to have_key(:attributes)
#       expect(item[:data][:attributes]).to be_a(Hash)
#       expect(item[:data][:attributes]).to have_key(:name)
#       expect(item[:data][:attributes][:name]).to be_a(String)
#       expect(item[:data][:attributes]).to have_key(:description)
#       expect(item[:data][:attributes][:description]).to be_a(String)
#       expect(item[:data][:attributes]).to have_key(:unit_price)
#       expect(item[:data][:attributes][:unit_price]).to be_a(Float)
#       expect(item[:data][:attributes]).to have_key(:merchant_id)
#       expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
#     end
#   end
#
#   describe 'sad path' do
#     it 'only accepts a JSON body with the following fields: name, description,
#         unit_price, and merchant_id' do
#
#       item_params = ({
#         name: 'Wobbler',
#         description: 'Wobbles',
#         unit_price: 12.50,
#         merchant_id: @merchant.id,
#         review: 'This is a great product'
#         })
#
#       headers = {"CONTENT_TYPE" => "application/json"}
#
#       post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
#
#       expect(response).to be_successful
#
#       item = JSON.parse(response.body, symbolize_names: true)
#
#       expect(item[:data]).to have_key(:id)
#       expect(item[:data][:id]).to be_an(String)
#       expect(item[:data]).to have_key(:type)
#       expect(item[:data][:type]).to be_a(String)
#       expect(item[:data][:type]).to eq('item')
#       expect(item[:data]).to have_key(:attributes)
#       expect(item[:data][:attributes]).to be_a(Hash)
#       expect(item[:data][:attributes]).to have_key(:name)
#       expect(item[:data][:attributes][:name]).to be_a(String)
#       expect(item[:data][:attributes]).to have_key(:description)
#       expect(item[:data][:attributes][:description]).to be_a(String)
#       expect(item[:data][:attributes]).to have_key(:unit_price)
#       expect(item[:data][:attributes][:unit_price]).to be_a(Float)
#       expect(item[:data][:attributes]).to have_key(:merchant_id)
#       expect(item[:data][:attributes][:merchant_id]).to be_an(Integer)
#       expect(item[:data]).to_not have_key(:review)
#     end
#
#     it 'will not create an Item without all of the following fields: name,
#         description, unit_price, and merchant_id' do
#
#       item_params = ({
#         name: 'Wobbler',
#         description: 'Wobbles',
#         })
#
#       headers = {"CONTENT_TYPE" => "application/json"}
#
#       post api_v1_items_path, headers: headers, params: JSON.generate(item: item_params)
#
#       expect(response).to be_successful
#
#       created_item = Item.last
#
#       expect(created_item).to eq(nil)
#     end
  # end

require 'rails_helper'

describe 'Merchants All Items' do
  before :each do
    @merchant_1 = create(:merchant, name: "Tubo")
    @item_1 = create(:item, merchant: @merchant_1)
    @item_2 = create(:item, merchant: @merchant_1)
    @item_3 = create(:item, merchant: @merchant_1)
    @item_4 = create(:item, merchant: @merchant_1)

    @merchant_2 = create(:merchant)
    @item_5 = create(:item, merchant: @merchant_2)
    @item_6 = create(:item, merchant: @merchant_2)
    @item_7 = create(:item, merchant: @merchant_2)
    @item_8 = create(:item, merchant: @merchant_2)

  end

  # it 'sends a list of all items associated with a particular merchant' do
  #
  #   get api_v1_items_merchant_path(@item_1.id) params: {name: "#{@item_1.name}"}
  #
  #   expect(response).to be_successful
  #
  #   merchant = JSON.parse(response.body, symbolize_names: true)
  #
  #   expect(merchant[:data]).to be_a(Hash)
  #   expect(merchant[:data]).to have_key(:id)
  #   expect(merchant[:data][:id]).to be_an(String)
  #   expect(merchant[:data]).to have_key(:type)
  #   expect(merchant[:data][:type]).to be_a(String)
  #   expect(merchant[:data]).to have_key(:attributes)
  #   expect(merchant[:data][:attributes]).to be_a(Hash)
  #   expect(merchant[:data][:attributes]).to have_key(:name)
  #   expect(merchant[:data][:attributes][:name]).to be_a(String)
  #   expect(merchant[:data][:attributes][:name]).to eq("Tubo")
  # end
end

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
      get api_v1_revenue_merchants_path 

      expect(response).to be_successful
    end
  end
end

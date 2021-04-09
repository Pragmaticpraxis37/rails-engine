require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'relationships' do
    it { should belong_to :merchant }
    it { should have_many :invoice_items }
    it { should have_many :invoices }
    it { should have_many(:invoices).through(:invoice_items) }
    it { should have_many :transactions }
    it { should have_many(:transactions).through(:invoices) }
  end

  describe 'instance methods' do
    it 'most_revenue' do
      @merchant_1 = create(:merchant)
      @item_1 = create(:item, merchant_id: @merchant_1.id)
      @item_2 = create(:item, merchant_id: @merchant_1.id)
      @item_3 = create(:item, merchant_id: @merchant_1.id)
      @item_4 = create(:item, merchant_id: @merchant_1.id)
      @invoice_1 = create(:invoice, merchant_id: @merchant_1.id, status: 'shipped')
      @invoice_2 = create(:invoice, merchant_id: @merchant_1.id, status: 'shipped')
      @invoice_3 = create(:invoice, merchant_id: @merchant_1.id, status: 'shipped')
      @invoice_items_1 = create(:invoice_item, item_id: @item_1.id, invoice_id: @invoice_1.id, quantity: 2, unit_price: 2)
      @invoice_items_2 = create(:invoice_item, item_id: @item_2.id, invoice_id: @invoice_1.id, quantity: 3, unit_price: 3)
      @invoice_items_3 = create(:invoice_item, item_id: @item_3.id, invoice_id: @invoice_2.id, quantity: 4, unit_price: 4)
      @invoice_items_4 = create(:invoice_item, item_id: @item_4.id, invoice_id: @invoice_3.id, quantity: 5, unit_price: 5)
      @transaction_1 = create(:transaction, invoice_id: @invoice_1.id, result: 'success')
      @transaction_2 = create(:transaction, invoice_id: @invoice_2.id, result: 'success')
      @transaction_3 = create(:transaction, invoice_id: @invoice_3.id, result: 'success')

      @merchant_2 = create(:merchant)
      @item_5 = create(:item, merchant_id: @merchant_2.id)
      @item_6 = create(:item, merchant_id: @merchant_2.id)
      @item_7 = create(:item, merchant_id: @merchant_2.id)
      @item_8 = create(:item, merchant_id: @merchant_2.id)
      @item_9 = create(:item, merchant_id: @merchant_2.id)
      @invoice_4 = create(:invoice, merchant_id: @merchant_2.id, status: 'shipped')
      @invoice_5 = create(:invoice, merchant_id: @merchant_2.id, status: 'shipped')
      @invoice_6 = create(:invoice, merchant_id: @merchant_2.id, status: 'shipped')
      @invoice_items_5 = create(:invoice_item, item_id: @item_5.id, invoice_id: @invoice_4.id, quantity: 6, unit_price: 6)
      @invoice_items_6 = create(:invoice_item, item_id: @item_6.id, invoice_id: @invoice_4.id, quantity: 7, unit_price: 7)
      @invoice_items_7 = create(:invoice_item, item_id: @item_7.id, invoice_id: @invoice_5.id, quantity: 8, unit_price: 8)
      @invoice_items_8 = create(:invoice_item, item_id: @item_8.id, invoice_id: @invoice_6.id, quantity: 9, unit_price: 9)
      @invoice_items_9 = create(:invoice_item, item_id: @item_9.id, invoice_id: @invoice_6.id, quantity: 10, unit_price: 10)
      @transaction_4 = create(:transaction, invoice_id: @invoice_4.id, result: 'success')
      @transaction_5 = create(:transaction, invoice_id: @invoice_5.id, result: 'success')
      @transaction_6 = create(:transaction, invoice_id: @invoice_6.id, result: 'success')

      @merchant_3 = create(:merchant)
      @item_10 = create(:item, merchant_id: @merchant_3.id)
      @invoice_7 = create(:invoice, merchant_id: @merchant_3.id, status: 'pending')
      @invoice_items_10 = create(:invoice_item, item_id: @item_10.id, invoice_id: @invoice_7.id, quantity: 11, unit_price: 11)
      @transaction_7 = create(:transaction, invoice_id: @invoice_7.id, result: 'success')

      @merchant_4 = create(:merchant)
      @item_11 = create(:item, merchant_id: @merchant_4.id)
      @invoice_8 = create(:invoice, merchant_id: @merchant_4.id, status: 'shipped')
      @invoice_items_11 = create(:invoice_item, item_id: @item_11.id, invoice_id: @invoice_8.id, quantity: 1, unit_price: 1)
      @transaction_8 = create(:transaction, invoice_id: @invoice_8.id, result: 'success')


      item_ids = [@item_9.id, @item_8.id, @item_7.id, @item_6.id, @item_5.id, @item_4.id, @item_3.id, @item_2.id, @item_1.id, @item_11.id]

      items_most_revenue = Item.most_revenue

      items_most_revenue_ids = items_most_revenue.map do |item|
                                  item.id
                                end

      expect(items_most_revenue.length).to eq(10)
      expect(items_most_revenue_ids).to eq(item_ids)

      items_most_revenue_variable_number = Item.most_revenue(4)
      expect(items_most_revenue_variable_number.length).to eq(4)
    end
  end
end

require 'rails_helper'

RSpec.describe 'SellingOrders', type: :system do
  let(:create_buyer) { create(:user, user_type: 'Buyer') }
  let(:create_broker) { create(:user, user_type: 'Broker') }

  let(:create_stock) do
    create(:stock, shares: 1234, user_id: create_broker.id)
  end

  let(:create_order) do
    create(:order, shares: 123,
                   user_id: create_buyer.id,
                   stock_id: create_stock.id)
  end

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is buyer' do
    let(:total_price) { (Order.find_by(stock_id: create_stock.id).unit_price * 12) }

    before do
      sign_in create_buyer
      create_stock
      create_order
      visit orders_all_path
      find("a[href='/stocks/#{create_stock.id}/orders/#{create_order.id}/edit']").click

      fill_in 'order[shares]', with: 12
      find('input[type="submit"]').click
    end

    it 'sells an order' do
      expect(Order.find_by(stock_id: create_stock.id).shares).to eq(123 - 12)
    end

    it 'increments its stock shares' do
      expect(Stock.find_by(id: create_stock.id).shares).to eq(1234 + 12)
    end

    it 'increments user money' do
      expect(User.find_by(id: create_buyer.id).money).to eq(create_buyer.money + total_price)
    end

    it "decrements broker's money" do
      expect(User.find_by(id: create_broker.id).money).to eq(create_broker.money - total_price)
    end
  end

  context 'when user signed in is not buyer' do
    before do
      sign_in create(:user)
    end

    it 'does not render page with sell button' do
      expect(page).not_to have_css("a[href='/stocks/#{create_stock.id}/orders/#{create_order.id}/edit']")
    end
  end
end

require 'rails_helper'

RSpec.describe 'CreatingOrders', type: :system do
  let(:create_buyer) { create(:user, user_type: 'Buyer') }
  let(:create_broker) { create(:user, user_type: 'Broker') }
  let(:create_stock) { create(:stock, user_id: create_broker.id) }
  let(:buy_button) { "a[href='/stocks/#{create_stock.id}/orders/new']" }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is buyer' do
    let(:order_shares) { Faker::Number.number(digits: 2) }
    let(:total_price) { (Order.find_by(stock_id: create_stock.id).unit_price * order_shares) }

    before do
      sign_in create_buyer
      create_stock
      visit stocks_market_path
      find(buy_button).click

      fill_in 'order[shares]', with: order_shares
      find('input[type="submit"]').click
    end

    it 'creates an order' do
      expect(Order.find_by(stock_id: create_stock.id)).not_to eq(nil)
    end

    it 'decrements its stock shares' do
      expect(Stock.find_by(id: create_stock.id).shares).to eq(create_stock.shares - order_shares)
    end

    it "decrements buyer's money" do
      expect(User.find_by(id: create_buyer.id).money).to eq(create_buyer.money - total_price)
    end

    it "increments broker's money" do
      expect(User.find_by(id: create_broker.id).money).to eq(create_broker.money + total_price)
    end
  end

  context 'when user signed in is not buyer' do
    before do
      sign_in create(:user)
      visit stocks_market_path
    end

    it 'does not render page with buy button' do
      expect(page).not_to have_css(buy_button)
    end
  end
end

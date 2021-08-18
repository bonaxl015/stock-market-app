require 'rails_helper'

RSpec.describe 'CreatingOrders', type: :system do
  let(:stock_shares) { Faker::Number.number(digits: 3) }
  let(:create_stock) { create(:stock, shares: stock_shares) }
  let(:buy_button) { "a[href='/stocks/#{create_stock.id}/orders/new']" }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is buyer' do
    let(:order_shares) { Faker::Number.number(digits: 2) }

    before do
      sign_in create(:user, user_type: 'Buyer')
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
      expect(Stock.find_by(id: create_stock.id).shares).to eq(stock_shares - order_shares)
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

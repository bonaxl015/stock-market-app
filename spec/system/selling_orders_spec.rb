require 'rails_helper'

RSpec.describe 'SellingOrders', type: :system do
  let(:create_user) { create(:user, user_type: 'Buyer') }
  let(:stock_shares) { Faker::Number.number(digits: 4) }

  let(:create_stock) do
    create(:stock, shares: stock_shares)
  end

  let(:create_order) do
    create(:order, shares: order_shares,
                  user_id: create_user.id,
                  stock_id: create_stock.id)
  end

  let(:sell_button) { "a[href='/stocks/#{create_stock.id}/orders/#{create_order.id}/edit']" }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is buyer' do
    let(:order_shares) { Faker::Number.number(digits: 3) }
    let(:sold_order_shares) { Faker::Number.number(digits: 2) }

    before do
      sign_in create_user
      create_stock
      create_order
      visit orders_all_path
      find(sell_button).click

      fill_in 'order[shares]', with: sold_order_shares
      find('input[type="submit"]').click
    end

    it 'sells an order' do
      expect(Order.find_by(stock_id: create_stock.id).shares).to eq(order_shares - sold_order_shares)
    end

    it 'increments its stock shares' do
      expect(Stock.find_by(id: create_stock.id).shares).to eq(stock_shares + sold_order_shares)
    end
  end

  context 'when user signed in is not buyer' do
    before do
      sign_in create(:user)
    end

    it 'does not render page with sell button' do
      expect(page).not_to have_css(sell_button)
    end
  end
end

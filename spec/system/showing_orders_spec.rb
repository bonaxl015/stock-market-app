require 'rails_helper'

RSpec.describe 'ShowingOrders', type: :system do
  let(:create_user) { create(:user, user_type: 'Buyer') }
  let(:create_order) { create(:order, user_id: create_user.id) }
  let(:show_button) { 'a[href="/orders/all"]' }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is buyer' do
    before do
      sign_in create_user
      create_order
      visit stocks_market_path
      find(show_button).click
    end

    it 'shows an order' do
      expect(page).to have_content(Order.find_by(user_id: create_user.id).name)
    end
  end

  context 'when user signed in is not buyer' do
    before do
      sign_in create(:user)
      visit stocks_market_path
    end

    it 'does not render page with show button' do
      expect(page).not_to have_css(show_button)
    end
  end
end

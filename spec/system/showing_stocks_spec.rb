require 'rails_helper'

RSpec.describe 'ShowingStocks', type: :system do
  let(:create_user) { create(:user, user_type: 'Broker') }
  let(:create_stock) { create(:stock, user_id: create_user.id) }
  let(:stock) { Stock.find_by(user_id: create_user.id).name }

  shared_examples 'a broker' do
    it 'shows a stock in stock market' do
      visit stocks_market_path
      expect(page).to have_content(stock)
    end
  end

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is broker' do
    before do
      sign_in create_user
      create_stock
    end

    include_examples 'a broker'

    it 'shows its own stocks' do
      visit stocks_market_path
      find('a[href="/stocks"]').click
      expect(page).to have_content(stock)
    end
  end

  context 'when user signed in is not broker' do
    before do
      sign_in create(:user)
      create_stock
    end

    it_behaves_like 'a broker'
  end
end

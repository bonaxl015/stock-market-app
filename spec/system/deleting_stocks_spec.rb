require 'rails_helper'

RSpec.describe 'DeletingStocks', type: :system do
  let(:name) { Faker::Company.unique.name }
  let(:create_stock) { create(:stock, name: name) }
  let(:delete_button) { "a[href='/stocks/#{create_stock.id}'][data-method='delete']" }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is broker' do
    before do
      sign_in create(:user, user_type: 'Broker')
      create_stock
      visit stocks_market_path
      find(delete_button).click
    end

    it 'deletes a stock' do
      expect(Stock.find_by(name: name)).to eq(nil)
    end
  end

  context 'when user signed in is not broker' do
    before do
      sign_in create(:user)
      create_stock
      visit stocks_market_path
    end

    it 'does not render page with delete button' do
      expect(page).not_to have_css(delete_button)
    end
  end
end

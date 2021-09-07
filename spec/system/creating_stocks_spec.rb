require 'rails_helper'

RSpec.describe 'CreatingStocks', type: :system do
  let(:name) { Faker::Company.unique.name }

  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is broker' do
    before do
      ENV['IEX_API_PUBLISHABLE_TOKEN'] = 'pk_a770dc46f21640ef9c61535093921ba2'
      sign_in create(:user, user_type: 'Broker')
      visit stocks_market_path
      find('a[href="/stocks/new"]').click
    end

    it 'creates a stock' do
      fill_in 'stock[name]', with: name
      fill_in 'stock[unit_price]', with: Faker::Number.between(from: 1, to: 10)
      fill_in 'stock[shares]', with: Faker::Number.number(digits: 4)
      click_on 'Submit'
      expect(Stock.find_by(name: name)).not_to eq(nil)
    end

    it 'searches a stock' do
      ENV['IEX_API_PUBLISHABLE_TOKEN'] = 'pk_a770dc46f21640ef9c61535093921ba2'
      fill_in 'Enter Stock Symbol', with: 'MSFT'
      click_on 'Search'
      expect(find_field('stock[name]').value).not_to eq(nil)
    end
  end

  context 'when user signed in is not broker' do
    before do
      sign_in create(:user)
      visit stocks_market_path
    end

    it 'does not render page with create button' do
      expect(page).not_to have_css('a[href="/stocks/new"]')
    end
  end
end

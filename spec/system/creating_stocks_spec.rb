# require 'rails_helper'

# RSpec.describe 'CreatingStocks', type: :system do
#   let(:name) { Faker::Company.unique.name }

#   before do
#     driven_by(:rack_test)
#   end

#   context 'when user signed in is broker' do
#     before do
#       sign_in create(:user, user_type: 'Broker')
#       visit stocks_market_path
#       find('a[href="/stocks/new"]').click

#       fill_in 'stock[name]', with: name
#       fill_in 'stock[unit_price]', with: Faker::Number.number(digits: 5)
#       fill_in 'stock[shares]', with: Faker::Number.number(digits: 6)
#       find('input[type="submit"]').click
#     end

#     it 'creates a stock' do
#       expect(Stock.find_by(name: name)).not_to eq(nil)
#     end
#   end

#   context 'when user signed in is not broker' do
#     before do
#       sign_in create(:user)
#       visit stocks_market_path
#     end

#     it 'does not render page with create button' do
#       expect(page).not_to have_css('a[href="/stocks/new"]')
#     end
#   end
# end

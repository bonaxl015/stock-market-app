# require 'rails_helper'

# RSpec.describe 'UpdatingStocks', type: :system do
#   let(:create_stock) { create(:stock) }
#   let(:name) { Faker::Company.unique.name }
#   let(:edit_button) { "a[href='/stocks/#{create_stock.id}/edit']" }

#   before do
#     driven_by(:rack_test)
#   end

#   context 'when user signed in is broker' do
#     before do
#       sign_in create(:user, user_type: 'Broker')
#       create_stock
#       visit stocks_market_path
#       find(edit_button).click

#       fill_in 'stock[name]', with: name
#       fill_in 'stock[unit_price]', with: Faker::Number.number(digits: 5)
#       fill_in 'stock[shares]', with: Faker::Number.number(digits: 6)
#       find('input[type="submit"]').click
#     end

#     it 'updates a stock' do
#       expect(Stock.find_by(name: name)).not_to eq(nil)
#     end
#   end

#   context 'when user signed in is not broker' do
#     before do
#       sign_in create(:user)
#       create_stock
#       visit stocks_market_path
#     end

#     it 'does not render page with edit button' do
#       expect(page).not_to have_css(edit_button)
#     end
#   end
# end

require 'rails_helper'

RSpec.describe 'ToppingUpMoneys', type: :system do
  let(:money) { Faker::Number.number(digits: 6) }
  let(:create_user) { create(:user, user_type: 'Buyer', money: money) }

  before do
    driven_by(:rack_test)
    sign_in create_user
    visit stocks_market_path
    find('a[href="/stocks/top_up"]').click

    fill_in 'Enter Amount', with: 10**5
    find('input[type="submit"]').click
  end

  it 'tops up money' do
    expect(User.find_by(id: create_user.id).money).to eq(money + 10**5)
  end
end

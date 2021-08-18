require 'rails_helper'

RSpec.describe "SigningInUsers", type: :system do
  shared_examples 'signs in user' do
    it 'signs in user' do
      expect(page).to have_content('Signed in successfully')
    end
  end

  before do
    driven_by(:rack_test)
  end

  context 'when user signing in is admin' do
    let(:create_admin_user) { create(:user, user_type: 'Admin') }

    before do
      create_admin_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_admin_user.email
      fill_in 'user[password]', with: create_admin_user.password
      find('input[type="submit"]').click
    end

    include_examples 'signs in user'

    it 'renders page with admin dashboard' do
      expect(page).to have_content('Site Administration')
    end
  end

  context 'when user signing in is not admin (broker)' do
    let(:create_broker_user) { create(:user, user_type: 'Broker') }

    before do
      create_broker_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_broker_user.email
      fill_in 'user[password]', with: create_broker_user.password
      find('input[type="submit"]').click
    end

    include_examples 'signs in user'

    it 'renders page with show stocks button' do
      expect(page).to have_css('a[href="/stocks"]')
    end
  end

  context 'when user signing in is not admin (buyer)' do
    let(:create_buyer_user) { create(:user, user_type: 'Buyer') }

    before do
      create_buyer_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_buyer_user.email
      fill_in 'user[password]', with: create_buyer_user.password
      find('input[type="submit"]').click
    end

    include_examples 'signs in user'

    it 'renders page with show orders button' do
      expect(page).to have_css('a[href="/orders/all"]')
    end
  end
end

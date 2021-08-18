require 'rails_helper'

RSpec.describe 'SigningInUsers', type: :system do
  shared_examples 'an admin signing in' do
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

    include_examples 'an admin signing in'
  end

  context 'when user signing in is not admin' do
    let(:create_broker_user) { create(:user) }

    before do
      create_broker_user
      visit root_path
      find('a[href="/users/sign_in"]').click

      fill_in 'user[email]', with: create_broker_user.email
      fill_in 'user[password]', with: create_broker_user.password
      find('input[type="submit"]').click
    end

    it_behaves_like 'an admin signing in'
  end
end

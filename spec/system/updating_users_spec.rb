require 'rails_helper'

RSpec.describe 'UpdatingUsers', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is admin' do
    let(:create_user) { create(:user, user_type: 'Broker') }
    let(:email) { Faker::Internet.unique.email }

    before do
      sign_in create(:user, user_type: 'Admin')
      create_user

      visit rails_admin.index_path('user')
      find("a[href*='user/#{create_user.id}/edit']").click

      fill_in 'user[email]', with: email
      find('button[name="_save"]').click
    end

    it 'updates a user' do
      expect(User.find_by(email: email)).not_to eq(nil)
    end
  end

  context 'when user signed in is not admin' do
    before do
      sign_in create(:user)
      visit rails_admin_path
    end

    it 'unauthorizes access' do
      expect(page).to have_content('not authorized')
    end
  end
end

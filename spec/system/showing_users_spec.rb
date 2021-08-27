require 'rails_helper'

RSpec.describe 'ShowingUsers', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is admin' do
    let(:create_user) { create(:user, user_type: 'Broker') }

    before do
      sign_in create(:user, user_type: 'Admin')
      create_user

      visit rails_admin.index_path('user')
    end

    it 'shows a user in all users page' do
      expect(page).to have_content(User.find_by(email: create_user.email).email)
    end

    it 'shows contents in a user' do
      find("a[href$='user/#{create_user.id}']").click
      expect(page).to have_content(User.find_by(email: create_user.email).username)
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

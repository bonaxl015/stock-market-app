require 'rails_helper'

RSpec.describe 'DeletingUsers', type: :system do
  before do
    driven_by(:rack_test)
  end

  context 'when user signed in is admin' do
    let(:create_user) { create(:user, user_type: 'Broker') }

    before do
      sign_in create(:user, user_type: 'Admin')
      create_user

      visit rails_admin.index_path('user')
      find("a[href*='user/#{create_user.id}/delete']").click
      click_on "Yes, I'm sure"
    end

    it 'deletes a user' do
      expect(User.find_by(id: create_user.id)).to eq(nil)
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

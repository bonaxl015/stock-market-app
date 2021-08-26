# require 'rails_helper'

# RSpec.describe 'CreatingUsers', type: :system do
#   before do
#     driven_by(:rack_test)
#   end

#   context 'when user signed in is admin' do
#     let(:email) { Faker::Internet.unique.email }
#     let(:password) { Faker::Internet.password }

#     before do
#       sign_in create(:user, user_type: 'Admin')
#       visit rails_admin_path
#       find('a[href*="user/new"]').click

#       fill_in 'user[email]', with: email
#       fill_in 'user[password]', with: password
#       fill_in 'user[password_confirmation]', with: password
#       fill_in 'user[username]', with: Faker::Lorem.unique.characters(number: 6)
#       select 'Broker', from: 'user[user_type]'
#       find('button[name="_save"]').click
#     end

#     it 'creates a user' do
#       expect(User.find_by(email: email, user_type: 'Broker')).not_to eq(nil)
#     end
#   end

#   context 'when user signed in is not admin' do
#     before do
#       sign_in create(:user)
#       visit rails_admin_path
#     end

#     it 'unauthorizes access' do
#       expect(page).to have_content('not authorized')
#     end
#   end
# end

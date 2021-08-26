# require 'rails_helper'

# RSpec.describe 'SigningUpUsers', type: :system do
#   let(:email) { Faker::Internet.unique.email }
#   let(:password) { Faker::Internet.password }
#   let(:click_signup_button) { find('input[type="submit"]').click }

#   before do
#     driven_by(:rack_test)

#     visit root_path
#     find('a[href="/users/sign_up"]', text: 'Sign Up').click

#     fill_in 'user[email]', with: email
#     fill_in 'user[username]', with: Faker::Lorem.unique.characters(number: 6)
#     fill_in 'user[password]', with: password
#     fill_in 'user[password_confirmation]', with: password
#   end

#   it 'signs up a broker user' do
#     select 'Broker', from: 'user[user_type]'
#     click_signup_button

#     expect(User.find_by(email: email, user_type: 'Broker')).not_to eq(nil)
#   end

#   it 'signs up a buyer user' do
#     select 'Buyer', from: 'user[user_type]'
#     click_signup_button

#     expect(User.find_by(email: email, user_type: 'Buyer')).not_to eq(nil)
#   end
# end

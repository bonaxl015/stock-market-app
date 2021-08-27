# require 'rails_helper'

# RSpec.describe User, type: :model do
#   subject(:user) { create(:user) }

#   it 'has many stocks' do
#     expect(described_class.reflect_on_association(:stocks).macro).to eq :has_many
#   end

#   it 'has many orders' do
#     expect(described_class.reflect_on_association(:orders).macro).to eq :has_many
#   end

#   it 'deletes its stocks' do
#     create(:stock)
#     user.destroy
#     expect(Stock.find_by(user_id: user.id)).to eq nil
#   end

#   it 'deletes its orders' do
#     create(:order)
#     user.destroy
#     expect(Order.find_by(user_id: user.id)).to eq nil
#   end

#   it 'validates with valid attributes' do
#     expect(user).to be_valid
#   end

#   describe '#username' do
#     it 'invalidates null' do
#       user.username = nil
#       user.valid?
#       expect(user.errors[:username].size).to eq(3)
#     end

#     it 'invalidates less than 6 characters' do
#       user.username = 'A' * 5
#       user.valid?
#       expect(user.errors[:username].size).to eq(1)
#     end

#     it 'invalidates special characters' do
#       user.username = '.' * 6
#       user.valid?
#       expect(user.errors[:username].size).to eq(1)
#     end

#     context 'when unique but case sensitive' do
#       let(:another) { create(:user) }

#       before do
#         user.username = another.username.upcase
#         user.valid?
#       end

#       it 'does not validate' do
#         expect(user.errors[:username].size).to eq(1)
#       end
#     end

#     context 'when unique but not case sensitive' do
#       let(:another) { create(:user) }

#       before do
#         user.username = another.username
#         user.valid?
#       end

#       it 'does not validate' do
#         expect(user.errors[:username].size).to eq(1)
#       end
#     end
#   end
# end

# require 'rails_helper'

# RSpec.describe Order, type: :model do
#   subject(:order) { create(:order) }

#   it 'belongs to user' do
#     expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
#   end

#   it 'belongs to stock' do
#     expect(described_class.reflect_on_association(:stock).macro).to eq :belongs_to
#   end

#   it 'validates with valid attributes' do
#     expect(order).to be_valid
#   end

#   describe '#name' do
#     it 'invalidates null' do
#       order.name = nil
#       order.valid?
#       expect(order.errors[:name].size).to eq(1)
#     end
#   end

#   describe '#unit price' do
#     it 'invalidates null' do
#       order.unit_price = nil
#       order.valid?
#       expect(order.errors[:unit_price].size).to eq(2)
#     end

#     it 'invalidates zero' do
#       order.unit_price = 0
#       order.valid?
#       expect(order.errors[:unit_price].size).to eq(1)
#     end
#   end

#   describe '#shares' do
#     it 'invalidates null' do
#       order.shares = nil
#       order.valid?
#       expect(order.errors[:shares].size).to eq(2)
#     end

#     it 'invalidates zero' do
#       order.shares = 0
#       order.valid?
#       expect(order.errors[:shares].size).to eq(1)
#     end
#   end
# end

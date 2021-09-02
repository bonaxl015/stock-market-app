# require 'rails_helper'

# RSpec.describe Order, type: :model do
#   subject(:order) do
#     create(:order,
#            shares: 1,
#            unit_price: stock.unit_price,
#            user_id: buyer.id,
#            stock_id: stock.id)
#   end

#   let(:buyer) { create(:user, money: 100) }
#   let(:stock) { create(:stock, unit_price: 10) }

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

#     it 'invalidates share purchase less than money' do
#       order.shares = 100
#       expect(order).not_to be_valid
#     end
#   end
# end

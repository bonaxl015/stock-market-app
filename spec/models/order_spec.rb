require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) do
    described_class.create(name: 'Order',
                           unit_price: 1000,
                           shares: 100,
                           user_id: user.id,
                           stock_id: stock.id)
  end

  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password',
                username: 'Username01',
                user_type: 'User')
  end

  let(:stock) do
    Stock.create(name: 'Stock',
                 unit_price: 1000,
                 shares: 100,
                 user_id: user.id)
  end

  context 'with associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'belongs to stock' do
      expect(described_class.reflect_on_association(:stock).macro).to eq :belongs_to
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(order).to be_valid
    end
  end

  context 'without a name' do
    before do
      order.name = nil
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end

  context 'when name is not unique but not case sensitive' do
    before do
      described_class.create(name: 'ORDER',
                             unit_price: 1000,
                             shares: 100,
                             user_id: user.id,
                             stock_id: stock.id)

      order.name = order.name
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end

  context 'without a unit price' do
    before do
      order.unit_price = nil
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end

  context 'when unit price is 0' do
    before do
      order.unit_price = 0
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end

  context 'without shares' do
    before do
      order.shares = nil
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end

  context 'when shares are 0' do
    before do
      order.shares = 0
    end

    it 'does not validate' do
      expect(order).not_to be_valid
    end
  end
end

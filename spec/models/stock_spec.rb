require 'rails_helper'

RSpec.describe Stock, type: :model do
  let(:user) do
    User.create(email: 'example@mail.com',
                password: 'password',
                username: 'Username01',
                user_type: 'User')
  end

  subject(:stock) do
    described_class.create(name: 'Stock',
                           unit_price: 1000,
                           shares: 100,
                           user_id: user.id)
  end

  context 'with associations' do
    it 'belongs to user' do
      expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
    end

    it 'has many orders' do
      expect(described_class.reflect_on_association(:orders).macro).to eq :has_many
    end
  end

  context 'with dependents' do
    let(:order) do
      Order.create(name: 'Orders',
                   unit_price: 1000,
                   shares: 1000,
                   user_id: user.id,
                   stock_id: stock.id)
    end

    it 'deletes its orders' do
      stock
      order
      user.destroy
      expect(Order.find_by(stock_id: stock.id)).to eq nil
    end
  end

  context 'with valid attributes' do
    it 'does validate' do
      expect(stock).to be_valid
    end
  end

  context 'without a name' do
    before do
      stock.name = nil
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end

  context 'when name is not unique but not case sensitive' do
    before do
      described_class.create(name: 'STOCK',
                             unit_price: 1000,
                             shares: 100,
                             user_id: user.id)

      stock.name = stock.name
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end

  context 'without a unit price' do
    before do
      stock.unit_price = nil
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end

  context 'when unit price is 0' do
    before do
      stock.unit_price = 0
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end

  context 'without shares' do
    before do
      stock.shares = nil
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end

  context 'when shares are 0' do
    before do
      stock.shares = 0
    end

    it 'does not validate' do
      expect(stock).not_to be_valid
    end
  end
end

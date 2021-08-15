require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) do
    described_class.create(email: 'example@mail.com',
                           password: 'password',
                           username: 'Username01',
                           user_type: user_type)
  end

  let(:stock) do
    Stock.create(name: 'Stocks',
                unit_price: 1000,
                shares: 1000,
                user_id: user.id)
  end

  context 'when user is a broker' do
    let(:user_type) { 'Broker' }

    context 'with associations' do
      it 'has many stocks' do
        expect(described_class.reflect_on_association(:stocks).macro).to eq :has_many
      end
    end

    context 'with dependents' do
      it 'deletes its stocks' do
        stock
        user.destroy
        expect(Stock.find_by(user_id: user.id)).to eq nil
      end
    end
  end

  context 'when user is a buyer' do
    let(:user_type) { 'Buyer' }

    context 'with associations' do
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
        expect(Order.find_by(user_id: user.id)).to eq nil
      end
    end
  end

  context 'with valid attributes' do
    let(:user_type) { 'Broker' }

    it 'does validate' do
      expect(user).to be_valid
    end
  end

  context 'without a username' do
    let(:user_type) { 'Broker' }

    before do
      user.username = nil
    end

    it 'does not validate' do
      expect(user).not_to be_valid
    end
  end

  context 'when username is not unique but not case sensitive' do
    let(:user_type) { 'Broker' }

    before do
      described_class.create(email: 'example@mail.com',
                             password: 'password',
                             username: 'USERNAME01',
                             user_type: 'Broker')

      user.username = user.username
    end

    it 'does not validate' do
      expect(user).not_to be_valid
    end
  end

  context 'when username is less than 6 characters' do
    let(:user_type) { 'Broker' }

    before do
      user.username = 'A' * 5
    end

    it 'does not validate' do
      expect(user).not_to be_valid
    end
  end

  context 'when username contains special characters' do
    let(:user_type) { 'Broker' }

    before do
      user.username = '.' * 6
    end

    it 'does not validate' do
      expect(user).not_to be_valid
    end
  end
end

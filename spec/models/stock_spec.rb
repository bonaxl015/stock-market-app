require 'rails_helper'

RSpec.describe Stock, type: :model do
  subject(:stock) { create(:stock) }

  it 'belongs to user' do
    expect(described_class.reflect_on_association(:user).macro).to eq :belongs_to
  end

  it 'has many orders' do
    expect(described_class.reflect_on_association(:orders).macro).to eq :has_many
  end

  it 'deletes its orders' do
    create(:order)
    stock.destroy
    expect(Order.find_by(stock_id: stock.id)).to eq nil
  end

  it 'validates with valid attributes' do
    expect(stock).to be_valid
  end

  describe '#name' do
    it 'invalidates null' do
      stock.name = nil
      stock.valid?
      expect(stock.errors[:name].size).to eq(1)
    end

    context 'when unique but case sensitive' do
      let(:another) { create(:stock) }

      before do
        stock.name = another.name.upcase
        stock.valid?
      end

      it 'does not validate' do
        expect(stock.errors[:name].size).to eq(1)
      end
    end

    context 'when unique but not case sensitive' do
      let(:another) { create(:stock) }

      before do
        stock.name = another.name.upcase
        stock.valid?
      end

      it 'does not validate' do
        expect(stock.errors[:name].size).to eq(1)
      end
    end
  end

  describe '#unit price' do
    it 'invalidates null' do
      stock.unit_price = nil
      stock.valid?
      expect(stock.errors[:unit_price].size).to eq(2)
    end

    it 'invalidates zero' do
      stock.unit_price = 0
      stock.valid?
      expect(stock.errors[:unit_price].size).to eq(1)
    end
  end

  describe '#shares' do
    it 'invalidates null' do
      stock.shares = nil
      stock.valid?
      expect(stock.errors[:shares].size).to eq(2)
    end

    it 'invalidates zero' do
      stock.shares = 0
      stock.valid?
      expect(stock.errors[:shares].size).to eq(1)
    end
  end
end

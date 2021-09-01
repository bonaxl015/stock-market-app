class Order < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  validates :name, presence: true
  validates :unit_price, presence: true,
                         numericality: { greater_than: 0 }
  validates :shares, presence: true,
                     numericality: { greater_than: 0 }
  validate :check_money

  def check_money
    unless self.shares.nil? || self.unit_price.nil?
      order_price = self.shares * self.unit_price
      buyer_money = self.user.money

      if order_price > buyer_money
        errors.add(:shares, 'You cannot afford that number of shares.')
      end
    end
  end
end

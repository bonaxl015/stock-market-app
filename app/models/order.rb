class Order < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  validates :name, presence: true
  validates :unit_price, presence: true,
                         numericality: { greater_than: 0 }
  validates :shares, presence: true,
                     numericality: { greater_than: 0 }

  validate :check_money, on: :create
  validate :check_shares

  def check_money
    return if shares.nil? || unit_price.nil?

    order_price = shares * unit_price
    buyer_money = user.money

    errors.add(:shares, 'You cannot afford that number of shares.') if order_price > buyer_money
  end

  def check_shares
    return if shares.nil? || stock.shares.nil?

    errors.add(:shares, 'Invalid number of shares.') if shares > stock.shares
  end
end

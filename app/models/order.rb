class Order < ApplicationRecord
  belongs_to :stock
  belongs_to :user

  validates :name, presence: true
  validates :unit_price, presence: true
  validates :shares, presence: true
end

class Stock < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true
  validates :unit_price, presence: true
  validates :shares, presence: true
end

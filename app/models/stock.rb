class Stock < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :unit_price, presence: true,
                         numericality: { greater_than: 0 }
  validates :shares, presence: true,
                     numericality: { greater_than: 0 }
end

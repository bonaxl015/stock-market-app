class Order < ApplicationRecord
    validates :name, presence: true
    validates :unit_price, presence: true
    validates :shares, presence: true
end

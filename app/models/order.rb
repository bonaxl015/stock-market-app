class Order < ApplicationRecord
    belongs_to :stock

    validates :name, presence: true
    validates :unit_price, presence: true
    validates :shares, presence: true
end

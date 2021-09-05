class Stock < ApplicationRecord
  has_many :orders, dependent: :destroy
  belongs_to :user

  validates :name, presence: true,
                   uniqueness: { case_sensitive: false }
  validates :unit_price, presence: true,
                         numericality: { greater_than: 0 }
  validates :shares, presence: true,
                     numericality: { greater_than: 0 }

  def self.iex_api
    IEX::Api::Client.new(
      publishable_token: ENV['IEX_API_PUBLISHABLE_TOKEN'],
      secret_token: ENV['IEX_API_SECRET_TOKEN'],
      endpoint: 'https://cloud.iexapis.com/v1'
    )
  end

  def self.lookup(stock)
    client = Stock.iex_api
    stock.upcase
    { name: client.quote(stock).symbol }
  end
end

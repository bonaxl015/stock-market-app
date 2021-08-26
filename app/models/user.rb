class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :username, presence: true,
                       uniqueness: { case_sensitive: false },
                       length: { minimum: 6 },
                       format: { with: /\A[A-Za-z0-9]+\z/ }
  has_many :stocks, dependent: :destroy
  has_many :orders, dependent: :destroy

  RailsAdmin.config do |config|
    config.model User do
      edit do
        configure :user_type, :enum do
          enum do
            [['Broker'], ['Buyer']]
          end
        end

        configure :reset_password_sent_at do
          hide
        end

        configure :remember_created_at do
          hide
        end
      end
    end
  end
end

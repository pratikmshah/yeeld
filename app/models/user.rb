class User < ActiveRecord::Base
  has_many :user_stocks
  has_many :stocks, through: :user_stocks

  has_many :user_watchlists
  has_many :watchlists, through: :user_watchlists

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end

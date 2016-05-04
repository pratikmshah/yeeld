class Watchlist < ActiveRecord::Base
  has_many :user_watchlists
  has_many :users, through: :user_watchlists
end

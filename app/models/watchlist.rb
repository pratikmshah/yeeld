class Watchlist < ActiveRecord::Base
  has_many :user_watchlists
  has_many :users, through: :user_watchlists

  # validate stock symbol and name are in the db and that only one instance is saved
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :ticker, presence: true

  # before saving uppercase all letters
  before_save :uppercase_field

end

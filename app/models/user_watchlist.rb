class UserWatchlist < ActiveRecord::Base
  belongs_to :user
  belongs_to :watchlist
end

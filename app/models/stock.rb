class Stock < ActiveRecord::Base
  # validate stock symbol and name are in the db and that only one instance is saved
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :ticker, presence: true, uniqueness: { case_sensitive: false }
end

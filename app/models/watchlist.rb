class Watchlist < ActiveRecord::Base
  has_many :user_watchlists
  has_many :users, through: :user_watchlists

  # validate stock symbol and name are in the db and that only one instance is saved
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :ticker, presence: true

  # before saving uppercase all letters
  before_save :uppercase_field


  # return ticker symbol in our database instead of querying
  def self.find_by_ticker(ticker_symbol)
    where(ticker: ticker_symbol).first
  end

  # lookup ticker through stock quote
  def self.new_from_lookup(ticker_symbol)
    looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
    return nil unless looked_up_stock.name

    new_watch = new(ticker: looked_up_stock.symbol, name: looked_up_stock.name)
    new_watch
  end

  # return current ask price of stock
  def self.price(ticker_symbol)
    StockQuote::Stock.quote(ticker_symbol).ask
  end

  # parse through array of watchlist objects returning ticker in new array
  def self.stock_tickers(watchlist_obj)
    watchlist_obj.map { |stock| stock.ticker }
  end

  private

    def uppercase_field
      self.ticker.upcase!
    end
end

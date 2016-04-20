module StocksHelper

  # returns stock data for requested stock
  def stock_info(tickers)
    YahooFinance::Client.new.quotes(tickers, info_request)
  end

  # list of all data pieces to retrieve for stock request
  def info_request
    [:name, :symbol, :ask, :change_and_percent_change, :last_trade_date, :days_range,
     :weeks_range_52, :open, :volume, :average_daily_volume, :market_capitalization,
     :pe_ratio, :dividend_per_share, :dividend_yield, :earnings_per_share, :float_shares, :ebitda, :change, :close, :previous_close]
  end

  # returns historical stock data for over a year
  def stock_historical_data(ticker)
    YahooFinance::Client.new.historical_quotes(ticker, { start_date: Date.today - 365, end_date: Date.today })
  end

  # return chart data
  def chart_data(ticker)
    data = stock_historical_data(ticker)
    dates = parse_date(data)
    prices = parse_price(data)
    parse_chart_data(dates, prices)
  end

  # get market price
  def get_market_price(stock)

    # get previous close value, convert to float and round to 2 decimals
    open = stock.previous_close.to_f.round(2)

    # get change value of stock, convert to array and then to float to 2 decimals
    change_val = stock.change.split().first[1..-1].to_f.round(2)

    #depending on if stock is up or down return price
    if stock.change[0] == '+'
      return (open + change_val)
    else
      return (open - change_val)
    end
  end

  # below methods to be used as helpers for the above methods
  # return dates
  def parse_date(stock_data)
    stock_data.map  { |date| date.trade_date }
  end

  # return closing stock price
  def parse_price(stock_data)
    stock_data.map { |price| price.close }
  end

  # convert arrays to date => price hash
  def parse_chart_data(dates, prices)
    dates.zip(prices).to_h
  end
end
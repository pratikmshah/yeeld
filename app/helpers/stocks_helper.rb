module StocksHelper

  # returns stock data for requested stock
  def stock_info(tickers)
    YahooFinance::Client.new.quotes(tickers, info_request)
  end

  # list of all data pieces to retrieve for stock request
  def info_request
    [:name, :symbol, :ask, :change_and_percent_change, :last_trade_date, :days_range,
     :weeks_range_52, :open, :volume, :average_daily_volume, :market_capitalization,
     :pe_ratio, :dividend_per_share, :dividend_yield, :earnings_per_share, :float_shares,
     :ebitda, :change, :close, :previous_close, :change_in_percent, :short_ratio]
  end

  # request watchlist info # also used for search
  def stock_watchlist(ticker)
    YahooFinance::Client.new.quotes(ticker, watchlist_info)
  end

  # watchlist info
  def watchlist_info
    [:name, :symbol, :change, :previous_close]
  end

  # returns historical stock data for over a year
  def stock_historical_data(ticker)
    ############################################################################
    # Yahoo Finance historical quotes has been deprecated
    # YahooFinance::Client.new.historical_quotes(ticker, { start_date: Date.today - days, end_date: Date.today })
    ############################################################################
    i = 0
    history = { date: [], price: [] }

    url = "https://finance.yahoo.com/quote/" + ticker + "/history?"
    doc = Nokogiri::HTML(open(url))
    data = doc.at('table[data-test="historical-prices"]')

    while i < data.children[1].children.length do
      check = data.children[1].children[i].text

      if (!check.include?('Dividend') && !check.include?('Split'))
      	history[:date] << data.children[1].children[i].children[0].text
      	history[:price] << data.children[1].children[i].children[5].text.to_f
      end

      i+=1
    end
    history
  end

  #  return chart options
  def chart_options(stock_symbol)
    { backgroundColor: "#212427", colors: ["#688AFC", "#999"], crosshair: { trigger: 'both' },
      legend: 'none', pointSize: 0, chartArea: {'width': '80%', 'height': '70%'} }
  end

  # return chart data
  def chart_data(ticker)
    data = stock_historical_data(ticker)
    # deprecated yahoo historical data api
    # dates = parse_date(data)
    # prices = parse_price(data)
    parse_chart_data(data[:date], data[:price])
  end

  # get market price
  def get_market_price(stock)

    # get previous close value, convert to float and round to 2 decimals
    open = stock.previous_close.to_f

    # get change value of stock, convert to array and then to float to 2 decimals
    change_val = stock.change.split().first[1..-1].to_f

    #depending on if stock is up or down return price
    if stock.change[0] == '+'
      return (open + change_val).round(2)
    else
      return (open - change_val).round(2)
    end
  end

  # below methods to be used as helpers for the above methods
  # return dates
  def parse_date(stock_data)
    stock_data.map  { |date| date.trade_date }
  end

  # return closing stock price
  def parse_price(stock_data)
    stock_data.map { |price| price.close.to_f.round(2) }
  end

  # convert arrays to date => price hash
  def parse_chart_data(dates, prices)
    dates.zip(prices).to_h
  end

  def price_high(hash)
    hash.max_by{|k,v| v}[1].to_i
  end

  def price_low(hash)
    hash.min_by{|k,v| v}[1].to_i
  end
end

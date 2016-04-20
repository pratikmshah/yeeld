class PortfolioController < ApplicationController

  def index
    @stock = Stock.new
    @user_portfolio = current_user.stocks               # get list of all user's stock porfolio
    @portfolio = Stock.stock_tickers(@user_portfolio)   # retrieve only the stock tickers from the list
  end

  def delete

  end
end

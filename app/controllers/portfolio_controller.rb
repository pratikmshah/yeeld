class PortfolioController < ApplicationController

  def index
    @stock = Stock.new
    @user_portfolio = current_user.stocks                         # get list of all user's stock porfolio
    @portfolio = Stock.stock_tickers(@user_portfolio).sort        # retrieve only the stock tickers from the list and sort by ticker symbol

    @watch = Watchlist.new                                        # to add stocks to watchlist
    @user_watchlist = current_user.watchlists
    @watchlist = Watchlist.stock_tickers(@user_watchlist).sort   # get only stocks on watchlist and sort by ticker symbol
    flash[:hide_form] = false;                                    # show add stock form
  end

  def show
    @stock = Stock.find(params[:id])
    @stock = Stock.stock_tickers([@stock])

    @watch = Watchlist.new
    @user_watchlist = current_user.watchlists
    @watchlist = Watchlist.stock_tickers(@user_watchlist).sort
    flash[:hide_form] = true;
  end

  def destroy
    user_portfolio_stock = UserStock.where(user_id: current_user.id, stock_id: params[:id])
    @stock_id = user_portfolio_stock.first.stock_id.to_s
    user_portfolio_stock.first.destroy
    flash[:notice] = "Stock has been removed from your portfolio"

    respond_to do |format|
      format.html { redirect_to portfolio_index_path }
      format.js
    end
  end
end

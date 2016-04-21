class PortfolioController < ApplicationController

  def index
    @stock = Stock.new
    @user_portfolio = current_user.stocks               # get list of all user's stock porfolio
    @portfolio = Stock.stock_tickers(@user_portfolio)   # retrieve only the stock tickers from the list
  end

  def show
    @stock = Stock.find(params[:id])
    @stock = Stock.stock_tickers([@stock])
  end

  def destroy
    user_portfolio_stock = UserStock.where(user_id: current_user.id, stock_id: params[:id])
    user_portfolio_stock.first.destroy
    flash[:notice] = "Stock has been removed from your portfolio"
    redirect_to portfolio_index_path
  end
end

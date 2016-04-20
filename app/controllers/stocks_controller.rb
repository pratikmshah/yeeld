class StocksController < ApplicationController

  def create
    user = current_user

    # check to see if stock is in db
    stock = Stock.find_by_ticker(stock_param[:ticker].upcase)
    if stock

      # check to see if user already has in portfolio
      if  UserStock.where(user_id: user.id, stock_id: stock.id).exists?
        p "ALREADY EXISTS IN PORTFOLIO*****************"
        flash[:notice] = "Stock already exists in your portfolio."
        portfolio_index
        redirect_to portfolio_index_path
      else
        add_stock = UserStock.new(user_id: user.id, stock_id: stock.id)   # create new record in join table
        add_stock.save
        portfolio_index
        redirect_to portfolio_index_path
      end

    else

      # if not check api to get values

    end

    # if not in api return back with error msg
  end

  private

    def stock_param
      params.require(:stock).permit(:ticker)
    end

    def portfolio_index
      @stock = Stock.new
      @user_portfolio = current_user.stocks
      @portfolio = Stock.stock_tickers(@user_portfolio)
    end
end

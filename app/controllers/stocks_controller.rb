class StocksController < ApplicationController

  def create
    user = current_user

    # check to see if stock is in db
    stock = Stock.find_by_ticker(stock_param[:ticker].upcase)
    if stock

      # check to see if user already has in portfolio
      if stock_in_portfolio?(user, stock)
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

      # if not check api to get values and then save stock
      stock = Stock.new_from_lookup(stock_param[:ticker])
      if stock.save

        # check to see if user already has in portfolio
        if stock_in_portfolio?(user, stock)
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
        # if not in api return back with error msg
        p "STOCK NOT FOUND*****************"
        flash[:notice] = "Stock was not found."
        portfolio_index
        redirect_to portfolio_index_path
      end
    end
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

    def stock_in_portfolio?(user, stock)
      UserStock.where(user_id: user.id, stock_id: stock.id).exists?
    end
end

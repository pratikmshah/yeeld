class StocksController < ApplicationController

  def create
    user = current_user

    # check to see if stock is in db
    stock = Stock.find_by_ticker(stock_param[:ticker].upcase)
    if stock

      # check to see if user already has in portfolio
      if stock_in_portfolio?(user, stock)
        flash[:notice] = "Stock already exists in your portfolio."
      else
        @add_stock = UserStock.new(user_id: user.id, stock_id: stock.id)   # create new record in join table
        @add_stock.save
        flash[:notice] = "Stock has been added to your portfolio."
      end

    else

      # if not check api to get values and then save stock
      stock = Stock.new_from_lookup(stock_param[:ticker])
      if stock
        stock.save

        # check to see if user already has in portfolio
        if stock_in_portfolio?(user, stock)
          flash[:notice] = "Stock already exists in your portfolio."
        else
          @add_stock = UserStock.new(user_id: user.id, stock_id: stock.id)   # create new record in join table
          @add_stock.save
          flash[:notice] = "Stock has been added to your portfolio."
        end

      else
        # if not in api return back with error msg
        flash[:notice] = "Stock was not found."
      end
    end

    respond_to do |format|
     format.html { redirect_to portfolio_index_path }
     format.js
    end
  end

  private

    def stock_param
      params.require(:stock).permit(:ticker)
    end

    def stock_in_portfolio?(user, stock)
      UserStock.where(user_id: user.id, stock_id: stock.id).exists?
    end
end

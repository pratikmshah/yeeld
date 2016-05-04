class WatchlistsController < ApplicationController

  def create
    user = current_user



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
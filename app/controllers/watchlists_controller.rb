class WatchlistsController < ApplicationController

  def create
    user = current_user

    # check to see if stock is in db
    watch = Watchlist.find_by_ticker(watchlist_param[:ticker].upcase)
    if watch

      # check to see if user already has in portfolio
      if !stock_in_portfolio?(user, watch)
        @add_stock_watchlist = UserWatchlist.new(user_id: user.id, watchlist_id: watch.id)   # create new record in join table
        @add_stock_watchlist.save
      end

    else

      # if not check api to get values and then save stock
      watch = Watchlist.new_from_lookup(watchlist_param[:ticker])
      if watch
        watch.save

        # check to see if user already has in portfolio
        if !stock_in_portfolio?(user, watch)
          @add_stock_watchlist = UserWatchlist.new(user_id: user.id, watchlist_id: watch.id)   # create new record in join table
          @add_stock_watchlist.save
        end

      else
        # if not in api return back with error msg
        flash[:notice] = "Symbol was not found."
      end
    end

    redirect_to portfolio_index_path
  end

  private

    def watchlist_param
      params.require(:watchlist).permit(:ticker)
    end

    def stock_in_portfolio?(user, watch)
      UserWatchlist.where(user_id: user.id, watchlist_id: watch.id).exists?
    end

end
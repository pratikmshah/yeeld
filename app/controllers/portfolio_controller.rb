class PortfolioController < ApplicationController

  def index
    @user_portfolio = current_user.stocks
  end

end

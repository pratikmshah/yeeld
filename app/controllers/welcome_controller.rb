class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # if user is logged in redirect to their portfolio all
    if user_signed_in?
      redirect_to portfolio_index_path
    end
  end
end
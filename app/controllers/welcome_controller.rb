class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    # if user is logged in redirect to user_stocks all
    if user_signed_in?
      redirect_to
    end
  end
end
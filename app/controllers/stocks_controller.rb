class StocksController < ApplicationController

  def index
    @stock = Stock.new
  end

end

require 'rails_helper'

RSpec.describe Stock, type: :model do
  it "should save stock symbol and name" do
    @stock = Stock.create!(ticker: 'MSFT', name: 'Micorsoft Corporation')
    expect(@stock.ticker).to eq('MSFT')
    expect(@stock.name).to eq('Micorsoft Corporation')
  end

  it "should not persist to the database" do
    @stock = Stock.new(ticker: 'MSFT')
    expect(@stock.save).to eq(false)
  end
end

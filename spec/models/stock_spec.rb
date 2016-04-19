require 'rails_helper'

RSpec.describe Stock, type: :model do

  lookup_stock = 'msft'

  # create stock model object
  before :each do
    @stock = Stock.create!(ticker: lookup_stock, name: 'Micorsoft Corporation')
  end

  it "should save stock symbol and name" do
    expect(@stock.ticker).to eq(lookup_stock.upcase)
    expect(@stock.name).to eq('Micorsoft Corporation')
  end

  it "should not persist to the database" do
    @stock = Stock.new(ticker: lookup_stock)
    expect(@stock.save).to eq(false)
  end

  it "returns stock in the database" do
    expect(Stock.find_by_ticker(lookup_stock.upcase)).to eq(@stock)
  end

  it "returns a new stock object" do
    expect(Stock.new_from_lookup('ibm')).to be_an_instance_of(Stock)
  end

  it "returns a new stock object" do
    expect(Stock.price(lookup_stock)).to be > 0
  end

  it "returns a new stock object" do
    @stock.save
    expect(@stock.ticker).to eq(lookup_stock.upcase)
  end

end

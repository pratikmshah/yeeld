require 'rails_helper'

RSpec.describe UserStock, type: :model do

  it "should save a link between user and stock" do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    stock = create(:stock, ticker: "T", name: "At&t")

    user_stock = UserStock.create(user: user, stock: stock)
    expect(UserStock.last).to eq(user_stock)
  end
end

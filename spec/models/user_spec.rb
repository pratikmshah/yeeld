require 'rails_helper'

RSpec.describe User, type: :model do

  it "creates a new user in the database" do
    user = create(:user, email: Faker::Internet.email, password: Faker::Internet.password)
    expect(User.last).to eq(user)
  end

  it "should deny creation of user" do
    user = build(:user, email: Faker::Internet.email)
    expect(user.save).to eq(false)
  end
end

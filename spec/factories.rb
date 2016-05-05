FactoryGirl.define do  factory :user_watchlist do
    user nil
watchlist nil
  end
  factory :watchlist do
    ticker "MyString"
name "MyString"
  end

  factory :user do
    email "foo@example.com"
    password "foobar"
  end

  factory :stock do
    ticker "vz"
    name   "Verizon"
  end
end
FactoryGirl.define do
  factory :user do
    email "foo@example.com"
    password "foobar"
  end

  factory :stock do
    ticker "vz"
    name   "Verizon"
  end
end
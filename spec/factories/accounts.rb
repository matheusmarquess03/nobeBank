FactoryBot.define do
  factory :account do
    user { User.first || association(:user) }
    balance { FFaker::Random.rand(1501.0..2000.0).round(2) }
    #account_number { 10 }
  end
end

FactoryBot.define do
  factory :account do
    user { User.first || association(:user) }
    balance { 100.00 }
    account_number { 10 }
  end
end

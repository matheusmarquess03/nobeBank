FactoryBot.define do
  factory :account do
    user { User.first || association(:user) }
    balance { 1.5 }
    account_number { 1 }
  end
end

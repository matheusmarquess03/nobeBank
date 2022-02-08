FactoryBot.define do
  factory :account do
    user { nil }
    balance { 1.5 }
    account_number { 1 }
  end
end

FactoryBot.define do
  factory :transfer do
    recipient { Account.first || association(:account) }
    sender { Account.first || association(:account) }
    type { 1 }
    value { "9.99" }
  end
end

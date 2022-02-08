FactoryBot.define do
  factory :user do
    email { 'nobe@nobe.com.br'}
    password {'123456'}

    trait :with_password_invalid do
      password { nil }
    end
  end
end

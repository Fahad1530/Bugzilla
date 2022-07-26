FactoryBot.define do
  factory :user do
    name { 'fahad' }
    email { 'joe@gmail.com' }
    password { '123456' }
    confirmed_at { 1.day.ago }
  end
end

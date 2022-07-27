# FactoryBot.define do
#   factory :user do
#     name { 'fahad' }
#     email { 'joe@gmail.com' }
#     password { '123456' }
#     confirmed_at { 1.day.ago }
#   end
# end

require 'faker'
FactoryBot.define do
  factory :user do
    # id { 1 }
    name { 'test_name' }
    email { Faker::Internet.email }
    password { 'testpass123' }
    confirmed_at { 1.day.ago }
  end
end

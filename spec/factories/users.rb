require 'faker'
FactoryBot.define do
  factory :user do
    name { 'test_name' }
    email { Faker::Internet.email }
    password { 'testpass123' }
    confirmed_at { 1.day.ago }
  end
end

FactoryBot.define do
  factory :bug do
    title { 'test_name' }
    deadline { '2022-08-28' }
    user_id { '1' }
    developer_id { '2' }
    project_id { '3' }
  end
end

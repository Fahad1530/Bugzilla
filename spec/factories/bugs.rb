# frozen_string_literal: true

FactoryBot.define do
  factory :bug do
    title { 'my new bug' }
    description { 'test_name sdmlkfm' }
    deadline { '02-08-2034' }
    bug_type { 'feature' }
    developer_id { '1' }
    image { fixture_file_upload 'app/assets/images/ava.png', 'application/png' }
    user
    project
  end
end

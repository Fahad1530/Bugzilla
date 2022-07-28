# frozen_string_literal: true

FactoryBot.define do
  factory :project_user do
    user
    project
  end
end

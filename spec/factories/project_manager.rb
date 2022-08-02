# frozen_string_literal: true

FactoryBot.define do
  factory :project_manager do
    user
    project
  end
end

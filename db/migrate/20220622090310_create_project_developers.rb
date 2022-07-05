# frozen_string_literal: true

class CreateProjectDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_developers, &:timestamps
  end
end

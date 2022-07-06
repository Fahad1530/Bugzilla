# frozen_string_literal: true

class CreateProjectManagers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_managers, &:timestamps
  end
end

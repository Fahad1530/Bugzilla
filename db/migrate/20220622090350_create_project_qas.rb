# frozen_string_literal: true

class CreateProjectQas < ActiveRecord::Migration[5.2]
  def change
    create_table :project_qas, &:timestamps
  end
end

# frozen_string_literal: true

class ChangeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :type, :bug_type
  end
end

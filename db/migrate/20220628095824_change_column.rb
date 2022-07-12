# frozen_string_literal: true

class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :assignment, :integer, using: 'assignment::integer'
  end
end

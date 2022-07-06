# frozen_string_literal: true

class AddDefault < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :bug_type, :integer, using: 'status::integer', default: 0
  end
end

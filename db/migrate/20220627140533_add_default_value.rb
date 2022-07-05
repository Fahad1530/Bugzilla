# frozen_string_literal: true

class AddDefaultValue < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :status, :integer, using: 'status::integer', default: 0
  end
end

class ChangeColumnType < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :status, :integer, using: 'status::integer'
    change_column :bugs, :bug_type, :integer, using: 'status::integer'

  end
end

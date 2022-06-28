class ChangeColumnAssignment < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :assignment, :developer_id
  end
end

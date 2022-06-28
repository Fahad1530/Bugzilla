class ChangeColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :bugs, :user_id, :creator_id
    change_column :bugs, :assignment, :integer, using: 'assignment::integer'
  end
end

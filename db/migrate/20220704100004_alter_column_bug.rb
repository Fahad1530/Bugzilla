class AlterColumnBug < ActiveRecord::Migration[5.2]
  def change
    change_column :bugs, :title, :string, null: false
  end
end

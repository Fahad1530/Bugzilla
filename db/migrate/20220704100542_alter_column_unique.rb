class AlterColumnUnique < ActiveRecord::Migration[5.2]
  def change
    change_column :projects, :title, :string, unique: true, null: false
  end
end

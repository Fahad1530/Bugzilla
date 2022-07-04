class RenameWorkinOn < ActiveRecord::Migration[5.2]
  def change
    rename_table :workin_ons, :project_users
  end
end

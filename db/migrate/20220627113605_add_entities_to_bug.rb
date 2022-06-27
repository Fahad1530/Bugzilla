class AddEntitiesToBug < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :title, :string, unique: true
    add_column :bugs, :status, :boolean
    add_column :bugs, :type, :string
    add_column :bugs, :deadline, :date
    add_column :bugs, :complete_status, :boolean
    add_reference :bugs, :user, index: true, foreign_key: true
    add_column :bugs, :assignment, :string
  end
end

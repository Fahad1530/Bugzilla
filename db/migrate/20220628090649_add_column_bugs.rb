class AddColumnBugs < ActiveRecord::Migration[5.2]
  def change
    add_column :bugs, :description, :string
  end
end

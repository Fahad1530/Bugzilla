class CreateProjectDevelopers < ActiveRecord::Migration[5.2]
  def change
    create_table :project_developers do |t|

      t.timestamps
    end
  end
end

class CreateProjectQas < ActiveRecord::Migration[5.2]
  def change
    create_table :project_qas do |t|

      t.timestamps
    end
  end
end

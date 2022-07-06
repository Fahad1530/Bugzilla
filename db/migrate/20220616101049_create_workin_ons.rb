# frozen_string_literal: true

class CreateWorkinOns < ActiveRecord::Migration[5.2]
  def change
    create_table :workin_ons do |t|
      t.references :user, foreign_key: true
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end

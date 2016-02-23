class CreateTimesheets < ActiveRecord::Migration
  def change
    create_table :timesheets do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :role_id, default: 0

      t.timestamps null: false
    end
  end
end

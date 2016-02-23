class CreateTimesheetRows < ActiveRecord::Migration
  def change
    create_table :timesheet_rows do |t|
      t.references :timesheet, index: true, foreign_key: true
      t.date :date_worked
      t.datetime :time_in
      t.datetime :time_out

      t.timestamps null: false
    end
  end
end

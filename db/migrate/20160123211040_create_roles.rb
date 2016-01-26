class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.boolean :tech
      t.boolean :checkout
      t.boolean :ta_grader
      t.boolean :supervisor

      t.timestamps null: false
    end
  end
end

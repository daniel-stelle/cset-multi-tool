class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :tech
      t.integer :checkout
      t.integer :ta_grader
      t.integer :supervisor

      t.timestamps null: false
    end
  end
end

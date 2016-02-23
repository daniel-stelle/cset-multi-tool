class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.boolean :tech,       default: false
      t.boolean :checkout,   default: false
      t.boolean :ta_grader,  default: false
      t.boolean :supervisor, default: false

      t.timestamps null: false
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstName
      t.string :lastName
      t.string :email
      t.integer :supervisor

      t.timestamps null: false
    end
  end
end

class AddRolesToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :roles, index: true, foreign_key: true
  end
end

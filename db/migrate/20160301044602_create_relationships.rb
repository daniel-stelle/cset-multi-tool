class CreateRelationships < ActiveRecord::Migration
  def change
    create_table :relationships do |t|
      t.integer :worker_id      # Follower
      t.integer :supervisor_id  # Followed

      t.timestamps null: false
    end
    
    add_index :relationships, :worker_id
    add_index :relationships, :supervisor_id
    
    # Unique so that workers cant be under a super more than once
    add_index :relationships, [:worker_id, :supervisor_id], unique: true
  end
end

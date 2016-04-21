class Relationship < ActiveRecord::Base
  belongs_to :worker,     class_name: 'User' # Follower
  belongs_to :supervisor, class_name: 'User' # Followed
  validates  :worker_id,     presence: true
  validates  :supervisor_id, presence: true
  
  before_save :check_duplicate
  
  def check_duplicate
    !Relationship.exists?(supervisor_id: supervisor_id, worker_id: worker_id)
  end
end

class User < ActiveRecord::Base
  has_one  :role,       dependent: :destroy
  has_many :timesheets, dependent: :nullify
  has_many :active_relationships,  class_name:  'Relationship',
                                   foreign_key: 'supervisor_id',
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  'Relationship',
                                   foreign_key: 'worker_id',
                                   dependent:   :destroy

  # @supervisor = User.find(supervisor_id)
  # @supervisor.workers.each { |w| w.timesheet }
  # @timesheets = User.where(supervisor_id: 1).map { |user| user.timesheet }
  has_many :workers,     through: :active_relationships,  source: :worker
  has_many :supervisors, through: :passive_relationships, source: :supervisor

  accepts_nested_attributes_for :role
  accepts_nested_attributes_for :timesheets

  attr_accessor :remember_token
  attr_accessor :worker_id
  attr_accessor :supervisor_id

  ### Before Actions ###

  before_save :down_case_email
  #--------------------#

  ### Validations ###

  # Name Validations
  validates :firstName, presence: true, length: { maximum: 50 }
  validates :lastName,  presence: true, length: { maximum: 50 }

  # Email Validations
  VALID_EMAIL_REGEX = /\A[\w]+\.[\w]+@oit\.edu\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  # Password Validations
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  #--------------------#

  ### Functions ###

  def full_name
    (firstName + ' ' + lastName).titleize
  end

  # Returns the hash digest of the given string.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Returns a random token.
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # Remembers a user in the database for use in persistent sessions.
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # Returns true if the given token matches the diges.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  # Forgets a user.
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Adds worker under the current user (supervisor)
  def add_worker(worker)
    unless Relationship.find_by_supervisor_id_and_worker_id(id, worker.id)
      active_relationships.create(worker_id: worker.id)
    end
  end

  # Removes worker from the current user (supervisor)
  def remove_worker(worker)
    active_relationships.find_by(worker_id: worker.id).destroy
  end

  # Returns true if the current user has the other user as a supervisor
  def has_supervisor?(supervisor)
    supervisors.include?(supervisor)
  end

  # Checks to see if the current user (supervisor) has a worker under them
  def has_worker?(worker)
    workers.include?(worker)
  end

  def root?
    email == 'daniel.stelle@oit.edu' ? true : false
  end

  class << self
    
    def students
      joins(:role).where('supervisor=?', false)
    end
    
  end

  private

    def down_case_email
      self.email = email.downcase
    end
end

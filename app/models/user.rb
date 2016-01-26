class User < ActiveRecord::Base
  belongs_to :role
  
  ### Before Actions ###
  
  before_save :down_case_email
  #--------------------#
  
  ### Validations ###
  
  # Name Validation
  validates :firstName, presence: true, length: { maximum: 50 }
  validates :lastName, presence: true, length: { maximum: 50 }
  
  # Email Validations
  VALID_EMAIL_REGEX = /\A[\w]+\.[\w]+@oit\.edu\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
                    
  # Password Validations
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }
  #--------------------#
  
  # @roles = %w["Role1", "Role2", "Role3"]
  
  # @roles.each do |role|
  #   self.send :define_method "#{role}?"
  #     return self.role <= some_val
  #   end
  # end
     
  private
    def down_case_email
      self.email = email.downcase
    end
end
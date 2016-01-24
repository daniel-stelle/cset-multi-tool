class User < ActiveRecord::Base
  
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
                    
  private
    def down_case_email
      self.email = email.downcase
    end
end
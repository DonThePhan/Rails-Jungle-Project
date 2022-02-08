class User < ActiveRecord::Base
  has_secure_password

  before_validation :process_email

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, uniqueness: true, presence: true
  validates :password, length: {minimum: 4}, presence: true
  validates :password_confirmation, presence: true


  def process_email
    if (self.email)
      self.email = self.email.downcase
      self.email = self.email.strip
    end
  end

  def self.authenticate_with_credentials (email, password)
    email = email.strip
    email = email.downcase
    self.find_by_email(email).authenticate(password)
  end
end


class Freelancer < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation, :status, :daily_rate
  has_secure_password

	before_save { |freelancer| freelancer.email = email.downcase }
	before_save :create_remember_token

  validates :name, presence: true
  validates :daily_rate, numericality: { :only_integer => true }, presence: true, on: :update
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :password_confirmation, presence: true, on: :create

  private

  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

end

class User < ApplicationRecord
  VALID_NAME_REGEX = /[a-zA-Z]/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  before_save { self.email.downcase! }
  validates :first_name, presence: true, format: { with: VALID_NAME_REGEX },
                         length: { minimum: 2 }
  validates  :last_name, presence: true, format: { with: VALID_NAME_REGEX },
                         length: { minimum: 2 }
  validates      :email, presence: true, length: { maximum: 255 },
                         format: { with: VALID_EMAIL_REGEX },
                         uniqueness: { case_sensitive: false }
  has_secure_password

  has_many :notes     

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end

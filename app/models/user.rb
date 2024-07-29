class User < ApplicationRecord
  has_secure_password
  has_many :likes
  has_many :posts, dependent: :destroy
  has_one_attached :avatar

  normalizes :email, with: -> (email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, presence: true
end

class User < ApplicationRecord
  has_secure_password
  has_many :likes
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  normalizes :email, with: -> (email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, presence: true
  validates :avatar, presence: true

  def username
    self.email.split("@").first.capitalize
  end

  def has_like_in? likeable
    likeable.likes.where(user_id: self.id).exists?
  end
end

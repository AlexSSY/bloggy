class User < ApplicationRecord
  after_commit :attach_avatar, on: :create

  has_secure_password
  has_many :likes
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :avatar

  normalizes :email, with: -> (email) { email.strip.downcase }

  validates :email, presence: true, uniqueness: true, format: URI::MailTo::EMAIL_REGEXP
  validates :password, presence: true

  def username
    self.email.split("@").first.capitalize
  end

  def has_like_in? likeable
    likeable.likes.where(user_id: self.id).exists?
  end

  def attach_avatar
    self.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', 'default-user.jpg')), filename: 'default-user.jpg', content_type: 'image/jpeg') unless self.avatar.attached?
  end
end

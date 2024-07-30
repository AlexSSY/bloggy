class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  normalizes :body, with: -> (body) { body.strip }
  
  validates :body, presence: true

  def owned_by(user)
    self.user_id == user.id
  end
end

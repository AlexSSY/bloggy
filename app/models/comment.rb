class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable

  normalizes :body, with: -> (body) { body.strip.downcase }
  
  validates :body, presence: true
end

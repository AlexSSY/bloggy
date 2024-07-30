class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable
  has_many :comments, -> { order('created_at DESC') }, dependent: :destroy
end

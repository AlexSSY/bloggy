class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable, dependent: :destroy
  has_many :comments, -> { order('created_at DESC') }, dependent: :destroy
  has_rich_text :body
end

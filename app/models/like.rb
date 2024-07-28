class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  # не дает возможности одному пользователю лайкнуть одну и туже запись больше одного раза
  validates :user_id, uniqueness: { scope: %i[ likeable_id likeable_type ] }
end

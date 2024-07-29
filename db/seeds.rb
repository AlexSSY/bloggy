# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'faker'
require 'open-uri'

def attach_avatar_to_user(user)
  user.avatar.attach(io: URI.open(Faker::Avatar.image(size: "128x128")), filename: user.email.gsub(/[@\.]/, "") + "_avatar.png")
end

me = User.create(email: "adolf5341@gmail.com", password: "gothic", password_confirmation: "gothic", admin: true)
Post.create(title: "Post from me", body: "Some text in the post", user: me)
attach_avatar_to_user me
other = User.create(email: "testuser@gmail.com", password: "gothic", password_confirmation: "gothic", admin: false)
attach_avatar_to_user other

10.times do 
  created_user = User.create(email: "#{Faker::Name.first_name}#{Faker::Number.number(digits: 4)}@example.com", password: "gothic", password_confirmation: "gothic", admin: false)
  attach_avatar_to_user created_user
  10.times do
    post = Post.create(title: Faker::Lorem.words.join(" "), body:Faker::Lorem.paragraphs(number: 400).join(" "), user: created_user)
    post.likes.create(user: me)
    post.likes.create(user: other)
    comment = Comment.create(user: me, post: post, body: Faker::Lorem.words(number: 7).join(" "))
    comment.likes.create(user: me)
    comment.likes.create(user: other)
  end
end
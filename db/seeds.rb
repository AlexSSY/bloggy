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

me = User.create(email: "adolf5341@gmail.com", password: "gothic", password_confirmation: "gothic", admin: true)
100.times do 
  created_user = User.create(email: "#{Faker::Name.first_name}#{Faker::Number.number(digits: 4)}@example.com", password: "gothic", password_confirmation: "gothic", admin: false)
  10.times do
    post = Post.create(title: Faker::Lorem.words.join(" "), body:Faker::Lorem.paragraphs.join(" "), user: created_user)
    post.likes.create(user: me)
    comment = Comment.create(user: me, post: post, body: Faker::Lorem.words(number: 7).join(" "))
    comment.likes.create(user: me)
  end
end
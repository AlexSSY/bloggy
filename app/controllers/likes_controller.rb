class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    if @likeable.likes.where(user_id: current_user.id).exists?
      @likeable.likes.where(user_id: current_user.id).destroy_all
    else
      @likeable.likes.create(user_id: current_user.id)
    end

    redirect_to @likeable
  end

  private

    def set_likeable
      @likeable = Post.find_by_id params[:post_id] if params[:post_id]
      @likeable = Comment.find_by_id params[:comment_id] if params[:comment_id]
    end
end

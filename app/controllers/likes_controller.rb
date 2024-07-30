class LikesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!
  before_action :set_likeable

  def create
    if @likeable.likes.where(user_id: current_user.id).exists?
      @likeable.likes.where(user_id: current_user.id).destroy_all
    else
      @likeable.likes.create(user_id: current_user.id)
    end

    respond_to do |format|
      format.html { redirect_to @likeable }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@likeable, :likes), partial: "likes/button", locals: {likeable: @likeable}) }
    end
  end

  private

    def set_likeable
      @likeable = Post.find_by_id params[:post_id] if params[:post_id]
      @likeable = Comment.find_by_id params[:comment_id] if params[:comment_id]
    end
end

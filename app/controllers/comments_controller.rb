class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.new comment_params
    if @comment.valid?
      @comment.save
      redirect_to @post
    else
      render template: "posts/show", status: :unprocessable_entity
    end
  end

  private

   def set_post
    @post = Post.find_by(id: params[:post_id])
   end

   def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
   end
end

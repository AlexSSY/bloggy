class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @post
    else
      render @post, status: :unprocessable_entity
    end
  end

  private

   def set_post
    @post = Post.find_by(id: params[:post_id])
   end

   def comment_params
    params.require(:comment).permit(:body)
   end
end

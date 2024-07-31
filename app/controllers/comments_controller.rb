class CommentsController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :authenticate_user!, except: :index
  before_action :set_post
  before_action :set_comment, only: :destroy

  def index
      render @post.comments.limit(index_params[:limit]).offset(index_params[:offset])
  end

  def create
    @comment = @post.comments.new comment_params
    if @comment.valid?
      @comment.save
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to render template: "posts/show", status: :unprocessable_entity }
        format.turbo_stream
      end
    end
  end

  def destroy
    if @comment.owned_by current_user
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @post }
        format.turbo_stream
      end
    else
      head :unprocessable_entity
    end
  end

  private

  def set_comment
    @comment = Comment.find_by_id params[:id]
  end

  def set_post
    @post = Post.find_by_id params[:post_id]
  end

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end

  def index_params
    params.permit(:offset, :limit).with_defaults(offset: 0, limit: 10)
  end
end

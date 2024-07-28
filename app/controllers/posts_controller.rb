class PostsController < ApplicationController
  before_action :set_post, only: :show

  def index
    @posts = Post.all.limit 10
  end

  def show
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end

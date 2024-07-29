class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_post, only: :show

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def show
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end
end

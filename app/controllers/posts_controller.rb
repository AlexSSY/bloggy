class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_post, only: :show

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def show
  end

  def search
    query = "%#{search_params[:query]}%"
    @pagy, @posts = pagy(Post.where("title LIKE ?", query))
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def search_params
      params.permit(:query).with_defaults(query: "")
    end
end

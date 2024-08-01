class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_post, only: :show
  before_action :authenticate_user!, only: %i[ new create ]

  def index
    @pagy, @posts = pagy(Post.all)
  end

  def show
  end

  def search
    query = "%#{search_params[:query]}%"
    @pagy, @posts = pagy(Post.where("title LIKE ?", query))
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    if @post.valid?
      @post.save
      redirect_to @post, notice: "Post successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

    def set_post
      @post = Post.find_by(id: params[:id])
    end

    def search_params
      params.permit(:query).with_defaults(query: "")
    end

    def post_params
      params.require(:post).permit(:title, :body).merge(user_id: current_user.id)
    end
end

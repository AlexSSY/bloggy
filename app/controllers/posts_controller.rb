class PostsController < ApplicationController
  include Pagy::Backend

  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :authenticate_user!, except: %i[ index show search ]
  before_action :check_post_owner!, only: %i[ edit update destroy ]

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

  def edit
  end

  def update
    if @post.update! update_params
      redirect_to @post, notice: "Post updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "Post deleted successfully."
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

    def update_params
      params.require(:post).permit(:title, :body)
    end

    def check_post_owner!
      redirect_to root_path, alert: "This is not your post scumbag!" unless @post.created_by current_user
    end
end

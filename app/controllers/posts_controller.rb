class PostsController < ApplicationController
  before_action :require_login, only: [:new, :create]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(posts_params)
    @post.user = User.find(params[:user_id])

    if @post.save
      flash[:success] = "Post created successfully"
      redirect_to user_posts_path
    else
      render :new, error: :unprocessable_entity
    end
  end

  def posts_params
    params.require(:post).permit(:title, :body)
  end

  def require_login
    unless user_signed_in?
      redirect_to new_user_session, alert: "You have to be signed in to create a post!"
    end
  end
end

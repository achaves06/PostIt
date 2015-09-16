class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :show]
  before_action :require_user, except: [:index, :show]


  def index
    @posts = Post.all.order('created_at DESC')
  end

  def show
    @categories = @post.categories
    @comments = @post.comments.order('id DESC')
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @categories = Category.all.order('name ASC')
  end

  def create
    @user = current_user
    @post = @user.posts.build(post_params)
    params[:post][:category_ids].delete_if{ |x| x.empty? } 
    if @post.save
      flash[:success] = "Your post was successfully created"
      redirect_to posts_path
    else
      @categories = Category.all.order('name ASC')
      render 'new'
    end
  end

  def edit
    @categories = Category.all.order('name ASC')
  end

  def update
    params[:post][:category_ids].delete_if{ |x| x.empty? } 
    if @post.update(post_params)
      flash[:success] = "Your post was successfully updated"
      redirect_to posts_path
    else
      render 'index'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :url, :description, :user_id, category_ids: [])
  end
end

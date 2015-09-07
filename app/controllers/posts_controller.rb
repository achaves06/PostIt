class PostsController < ApplicationController

  before_action :set_post, only: [:edit, :update, :show]


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
    @user = User.first
    @post = @user.posts.build(post_params)
    binding.pry
    params[:post][:category_ids].delete_if{ |x| x.empty? } # multi selects come with first array as empty need to remove this to avoid assigning nil category_id
    @category_ids = params[:post][:category_ids]
    @post.category_ids = @category_ids if !@category_ids.nil?

    binding.pry
    if @post.save
      flash[:success] = "Your post was successfully created"
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def edit

  end
  def update
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
    params.require(:post).permit(:title, :url, :description, :user_id)
  end
end

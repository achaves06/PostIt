class CategoriesController < ApplicationController

  before_action :find_category, only: [:show, :edit, :update]

  def index
    @categories = Category.all
  end

  def show
    @posts = @category.posts
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Your post was successfully created"
      redirect_to categories_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      flash[:success] = "Updates successfully saved"
      redirect_to categories_path
    else
      render 'index'
    end
  end



  private

  def category_params
    params.require(:category).permit(:name)
  end

  def find_category
    @category = Category.find(params[:id])
  end
end

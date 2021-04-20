class CategoriesController < ApplicationController
  before_action :set_category, only: [:edit, :update, :destroy, :show]

  def index
    @category = Category.new
    @categories = Category.all
    @parents = Category.where(ancestry: nil)
  end

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.order("created_at DESC").page(params[:page]).per(5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to categories_path
    else
      #@categories = Category.all
      render 'index'
    end
  end

  def edit
  end

  def update
    if @category.update(category_params)
      redirect_to categories_path
    else
      render 'edit'
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end


  private

  def set_category
    @category = Category.find(params[:id])
    if @category.has_children?
      @category_links = @category.children
    else
      @category_links = @category.siblings
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end
end

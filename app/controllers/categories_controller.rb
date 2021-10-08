class CategoriesController < ApplicationController
  before_action :check_permissions, only: %i[edit update destroy]
  before_action :find_categories, only: %i[edit update destroy]

  def index
    @category = Category.all
  end

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new(my_params)

    if @categories.save
      redirect_to categories_path
    else
      render :new
    end
    # byebug
  end

  def show
    @categories = Category.all
  end

  def edit; end

  def update
    if @category.update(my_params)
      redirect_to categories_path
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private

  def my_params
    params.require(:category).permit(:name, :avatar)
  end

  def check_permissions
    @categories = Category.find(params[:id])
    # authorize @items
  end

  def find_categories
    @category = Category.find(params[:id])
  end
end

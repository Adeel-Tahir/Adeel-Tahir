# frozen_string_literal: true

class CategoriesController < ApplicationController
  before_action :find_categories, only: %i[edit update destroy]
  before_action :check_permissions, only: %i[edit update destroy create new]

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      flash[:notice] = 'Category Created'
      redirect_to categories_path
    else
      render :new, flash[:alert] = 'Category cant be Created'
    end
  end

  def show
    @categories = Category.all
  end

  def edit; end

  def update
    if @category.update(category_params)
      flash[:notice] = 'Category Updated'
      redirect_to categories_path
    else
      render :edit, flash[:alert] = 'Category not updated'
    end
  end

  def destroy
    if @category.destroy
      flash[:notice] = 'Category deleted'
    else
      flash[:alert] = 'Category not deleted'
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :avatar)
  end

  def check_permissions
    authorize Category
  end

  def find_categories
    @category = Category.find_by(id: params[:id])
  end
end

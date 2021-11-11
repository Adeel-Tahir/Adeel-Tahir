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

    begin
      @category.save!
      redirect_to categories_path, notice: 'Category Created'
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_category_path, alert: e.record.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    @category&.update!(category_params)
    flash[:notice] = 'Category Updated'
    redirect_to categories_path
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_category_path, alert: e.record.errors.full_messages.to_sentence
  end

  def destroy
    if @category&.destroy
      flash[:notice] = 'Category deleted'
    else
      flash[:alert] = 'Category not deleted'
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :image)
  end

  def check_permissions
    authorize Category
  end

  def find_categories
    @category = Category.find_by(id: params[:id])
  end
end

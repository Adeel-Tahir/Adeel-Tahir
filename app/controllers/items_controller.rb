# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :check_permissions, only: %i[edit update destroy]
  before_action :find_resturant, only: %i[index create show]
  before_action :find_items, only: %i[edit update destroy]
  before_action :category_list, only: %i[edit create new]

  def index
    @categories = Category.all
    @resturant = @res.items
    cate = params[:cate]
    if !cate.nil?
      cat = Category.find(cate)

      @resturant = cat.items.where(resturant_id: params[:resturant_id])
    else
      @resturant = @res.items
    end
    @resturant = @resturant.search(params[:search].downcase) if params[:search].present?
    @resturant = @resturant.filter1(params[:item][:category_id]) if params[:item] && !params[:item][:category_id].empty?
  end

  def new
    @items = Item.new
    authorize @items
  end

  def create
    # byebug
    @items = @res.items.new(my_params)
    if @items.save
      redirect_to resturant_items_path
    else
      render :new
    end
    # byebug
    cat_id = params[:item][:id]
    cat = Category.find(cat_id)
    @items.categorizations.create(category: cat)
  end

  def show
    @resturant = @res.items
  end

  def edit; end

  def update
    if @item.update(my_params)
      redirect_to resturant_items_path(resturant_id: @item.resturant.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to resturant_items_path
  end

  private

  def my_params
    params.require(:item).permit(:name, :price, :description, :avatar, category_ids: [])
  end

  def check_permissions
    @items = Item.find(params[:id])
    authorize @items
  end

  def find_resturant
    @res = Resturant.find(params[:resturant_id])
  end

  def find_items
    @item = Item.find(params[:id])
  end

  def category_list
    @category_list = Category.all.pluck(:name, :id).to_h
  end
end

# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :check_permission, only: %i[edit update destroy new create]
  before_action :find_resturant, only: %i[index create show]
  before_action :find_item, only: %i[edit update destroy]
  before_action :category_list, only: %i[edit create new]

  def index
    @categories = Category.all
    @resturant = @res.items
    search_item
  end

  def new
    @item = Item.new
  end

  def create
    @item = @res.items.new(item_params)
    if @item.save
      redirect_to resturant_items_path, notice: 'Item Created'
    else
      render :new
    end
    cat_id = params[:item][:id]
    cat = Category.find_by(id: cat_id)
    @items.categorizations.create(category: cat) unless cat.nil?
  end

  def show
    @item = Item.find_by(id: params[:id])
    redirect_to resturants_path, alert: 'Item not found' if @item.nil?
  end

  def edit; end

  def update
    if @item.update(item_params)
      flash[:notice] = 'Item Updated'
      redirect_to resturant_items_path(resturant_id: @item.resturant.id)
    else
      render :edit, flash[:alert] = 'Item not Updated'
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = 'Item deleted'
    else
      flash[:alert] = 'Item can not be deleted'
    end
    redirect_to resturant_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :status, :avatar, category_ids: [])
  end

  def check_permission
    authorize Item
  end

  def find_resturant
    @res = Resturant.find_by(id: params[:resturant_id])
  end

  def find_item
    @item = Item.find_by(id: params[:id])
  end

  def category_list
    @category_list = Category.all.pluck(:name, :id).to_h
  end

  def search_item
    find_category_by_resturant
    search_resturant
    @resturant = @resturant.filter1(params[:item][:category_id]) if params[:item] && !params[:item][:category_id].empty?
  end

  def find_category_by_resturant
    cate = params[:cate]
    if !cate.nil?
      @cat = Category.find_by(id: cate)
      if @cat.nil?
        redirect_to resturant_items_path, alert: 'Category not found'
      else
        @resturant = @cat.items.find_resturant_item(params[:resturant_id])
      end
    else
      @resturant = @res.items
    end
  end

  def search_resturant
    @resturant = @resturant.search(params[:search].downcase) if params[:search].present?
  end
end

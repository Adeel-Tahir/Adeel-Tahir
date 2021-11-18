# frozen_string_literal: true

class ItemsController < ApplicationController
  before_action :check_permission, only: %i[edit update destroy new create]
  before_action :find_resturant, only: %i[index create show]
  before_action :find_item, only: %i[edit update destroy show]

  def index
    @categories = Category.all
    @pagy, @resturant = pagy(@resturant.items)
    search_item
  end

  def new
    @item = Item.new
  end

  def create
    @item = @resturant.items.new(item_params)

    begin
      @item.save!
      redirect_to resturant_items_path, notice: 'Item Created'
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_resturant_item_path(resturant_id: @item.resturant.id),
                  alert: e.record.errors.full_messages.to_sentence
    end
  end

  def show
    redirect_to resturants_path, alert: 'Item not found' if @item.nil?
    @resturant = @item.resturant.items
  end

  def edit; end

  def update
    @item&.update!(item_params)
    redirect_to resturant_items_path(resturant_id: @item.resturant.id), notice: 'Item Updated'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_resturant_item_path(resturant_id: @item.resturant.id), alert: e.record.errors.full_messages
  end

  def destroy
    if @item&.destroy
      flash[:notice] = 'Item deleted'
    else
      flash[:alert] = 'item not deleted'
    end
    redirect_to resturant_items_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :price, :description, :status, :image, category_ids: [])
  end

  def check_permission
    authorize Item
  end

  def find_resturant
    @resturant = Resturant.find_by(id: params[:resturant_id])
  end

  def find_item
    @item = Item.find_by(id: params[:id])
  end

  def find_category_by_resturant
    return if params[:cate].nil?

    cat = Category.find_by(id: params[:cate])
    @resturant = cat.items.find_resturant_item(params[:resturant_id])
  end

  def search_item
    find_category_by_resturant
    @resturant = @resturant.search_item_name(params[:search].downcase) if params[:search].present?
  end
end

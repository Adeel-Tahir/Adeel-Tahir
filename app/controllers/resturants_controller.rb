# frozen_string_literal: true

class ResturantsController < ApplicationController
  before_action :check_permissions, only: %i[edit update destroy]
  before_action :find_resturant, only: %i[edit update destroy]

  def index
    @resturants = Resturant.all
  end

  def new
    @resturants = Resturant.new
    authorize @resturants
  end

  def create
    @resturants = Resturant.new(my_params)
    if @resturants.save
      redirect_to resturants_path(@resturants.id)
    else
      render :new
    end
  end

  def show
    @resturants = Resturant.all
  end

  def edit; end

  def update
    if @resturants.update(my_params)
      redirect_to resturants_path
    else
      render 'edit'
    end
  end

  def destroy
    @resturants.destroy
    redirect_to resturants_path
  end

  private

  def my_params
    params.require(:resturant).permit(:name, :avatar)
  end

  def find_resturant
    @resturants = Resturant.find(params[:id])
  end

  def check_permissions
    @resturants = Resturant.find(params[:id])
    authorize @resturants
  end
end

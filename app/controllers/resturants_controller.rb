# frozen_string_literal: true

class ResturantsController < ApplicationController
  before_action :find_resturant, only: %i[edit update destroy]
  before_action :check_permissions, only: %i[edit update destroy]
  after_action :check_permissions, only: %i[new create]

  def index
    @resturants = Resturant.all
  end

  def new
    @resturant = Resturant.new
  end

  def create
    @resturant = Resturant.new(resturant_params)
    if @resturant.save
      redirect_to resturants_path(@resturant.id)
    else
      render :new
    end
  end

  def show
    @resturants = Resturant.all
  end

  def edit; end

  def update
    if @resturant.update(resturant_params)
      redirect_to resturants_path
    else
      render 'edit'
    end
  end

  def destroy
    @resturant.destroy
    redirect_to resturants_path
  end

  private

  def resturant_params
    params.require(:resturant).permit(:name, :avatar)
  end

  def find_resturant
    @resturant = Resturant.find(params[:id])
  end

  def check_permissions
    authorize @resturant
  end
end

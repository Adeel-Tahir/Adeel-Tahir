# frozen_string_literal: true

class ResturantsController < ApplicationController
  before_action :find_resturant, only: %i[edit update destroy]
  before_action :check_permissions, only: %i[edit update destroy]
  # after_action :check_permissions, only: %i[new create]

  def index
    @resturants = Resturant.all
  end

  def new
    @resturant = Resturant.new
  end

  def create
    @resturant = Resturant.new(resturant_params)
    if @resturant.save
      flash[:notice] = 'Resturant Created'
      redirect_to resturants_path(@resturant.id)
    else
      flash[:alert] = 'Resturant not Created'
      render :new
    end
  end

  def show
    @resturants = Resturant.all
  end

  def edit; end

  def update
    if @resturant.update(resturant_params)
      flash[:notice] = 'Resturant updated'
      redirect_to resturants_path
    else
      flash[:notice] = 'Resturant not updated'
      render 'edit'
    end
  end

  def destroy
    if @resturant.destroy
      flash[:notice] = 'Resturant deleted'
    else
      flash[:alert] = 'Resturant can not deleted'
    end
    redirect_to resturants_path
  end

  private

  def resturant_params
    params.require(:resturant).permit(:name, :avatar)
  end

  def find_resturant
    @resturant = Resturant.find_by(id: params[:id])
  end

  def check_permissions
    authorize @resturant
  end
end

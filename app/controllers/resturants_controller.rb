# frozen_string_literal: true

class ResturantsController < ApplicationController
  before_action :find_resturant, only: %i[edit update destroy]
  before_action :check_permissions, only: %i[edit update destroy create new]

  def index
    @pagy, @resturants = pagy(Resturant.all)
  end

  def new
    @resturant = Resturant.new
  end

  def create
    @resturant = Resturant.new(resturant_params)
    begin
      @resturant.save!
      redirect_to resturants_path(@resturant.id), notice: 'Resturant Created'
    rescue ActiveRecord::RecordInvalid => e
      redirect_to new_resturant_path, alert: e.record.errors.full_messages.to_sentence
    end
  end

  def edit; end

  def update
    @resturant&.update!(resturant_params)
    redirect_to resturants_path(@resturant.id), notice: 'Resturant updated'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to edit_resturant_path, alert: e.record.errors.full_messages.to_sentence
  end

  def destroy
    if @resturant&.destroy
      flash[:notice] = 'Resturant deleted'
    else
      flash[:alert] = 'Resturant can not deleted'
    end
    redirect_to resturants_path
  end

  private

  def resturant_params
    params.require(:resturant).permit(:name, :image)
  end

  def find_resturant
    @resturant = Resturant.find_by(id: params[:id])
    return unless @resturant.nil?

    redirect_to resturants_path, alert: 'Resturant not Found'
  end

  def check_permissions
    authorize Resturant
  end
end

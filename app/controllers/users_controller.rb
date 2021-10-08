# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @users = User.order(created_at: :desc)
    # authorize @users
  end

  def update
    @users = User.order(created_at: :desc)
    # authorize @users
  end

  def destroy
    @users = User.order(created_at: :desc)
    # authorize @users
  end

  def edit
    @users = User.order(created_at: :desc)
    # authorize @users
  end
end

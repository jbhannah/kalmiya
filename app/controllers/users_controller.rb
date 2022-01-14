# frozen_string_literal: true

# User account management controller
class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.create!(user_params)
    redirect_back_or_to root_url
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password)
  end
end

# frozen_string_literal: true

# Sessions controller
class SessionsController < ApplicationController
  def index; end

  def new; end

  def create
    user = User.find_by!(email: session_params[:email]).authenticate!(session_params[:password])
    session[:jwt] = user.sessions.create!(created_from: request.remote_ip).to_jwt
    redirect_to root_url
  end

  def destroy; end

  private

  def session_params
    params.require(:user).permit(:email, :password)
  end
end

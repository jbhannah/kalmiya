# frozen_string_literal: true

# Sessions controller
class SessionsController < ApplicationController
  def index; end

  def new; end

  def create
    user = User.find_by!(email: new_session_params[:email]).authenticate!(new_session_params[:password])
    session[:jwt] = user.sessions.create!(created_from: request.remote_ip).to_jwt
    redirect_to root_url
  end

  def destroy
    if destroy_session_params.key?(:id)
      current_user.sessions.find(destroy_session_params[:id]).destroy!
      redirect_to sessions_path
    else
      current_session.destroy!
      reset_session
      redirect_to root_url
    end
  end

  private

  def destroy_session_params
    params.permit(:session).permit(:id)
  end

  def new_session_params
    params.require(:user).permit(:email, :password)
  end
end

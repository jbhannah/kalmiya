# frozen_string_literal: true

# Sessions controller
class SessionsController < ApplicationController
  skip_before_action :current_user, only: %i[new create]

  rescue_from UserAuthenticationError, with: :redirect_to_new

  def index; end

  def new
    flash.keep(:redirect)
  end

  def create
    user = User.find_and_authenticate_by!(**new_session_params.to_h.symbolize_keys)
    session[:jwt] = user.sessions.create!(created_from: request.remote_ip).to_jwt
    redirect_to flash[:redirect] || root_url
  end

  def destroy
    if destroy_session_params.key?(:id)
      current_user.sessions.find(destroy_session_params[:id]).destroy!
      redirect_to sessions_path, status: :see_other
    else
      current_session.destroy!
      reset_session
      redirect_to root_url, status: :see_other
    end
  end

  private

  def destroy_session_params
    params.permit(:session).permit(:id)
  end

  def new_session_params
    params.require(:user).permit(:email, :password)
  end

  def redirect_to_new
    flash.keep(:redirect)
    redirect_to action: :new
  end
end

# frozen_string_literal: true

# Base application controller
class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  after_action :refresh_session, if: :logged_in?

  protected

  def current_session
    @current_session ||= session_from_jwt
  end

  def current_user
    @current_user ||= current_session.user
  end

  def logged_in?
    session.key?(:jwt)
  end

  private

  def jwt
    @jwt ||= session[:jwt]
  end

  def refresh_session
    session[:jwt] = current_session.to_jwt
  end

  def session_from_jwt
    Session.from_jwt(jwt).tap do |jwt_session|
      jwt_session.update!(last_accessed_from: request.remote_ip, last_accessed_at: Time.zone.now)
    end
  end
end

class ApplicationController < ActionController::Base
  config.time_zone = 'Pacific Time (US & Canada)'
  protect_from_forgery with: :exception
  
  def user_signed_in?
    if session[:user_id].present? && current_user.nil?
      session[:user_ud] = nil
    end
    session[:user_id].present?
  end

  helper_method :user_signed_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  helper_method :current_user

private

  def authenticate_user!
    if !user_signed_in?
      redirect_to new_session_path, alert: 'You must be signed in to perform that action.'
    end
  end
end
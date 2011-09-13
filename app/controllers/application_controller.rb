class ApplicationController < ActionController::Base
  # FIXME: strange problems on creating new reservations... :(
  # protect_from_forgery
  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def requires_login
    redirect_to log_in_path unless current_user
  end
end

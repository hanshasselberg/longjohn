class ApplicationController < ActionController::Base
  # FIXME: strange problems on creating new reservations... :(
  # protect_from_forgery
  before_filter :set_locale

  expose(:equipment_reservations) do
    current_user.equipment_reservations.sort_by{ |r| r.from }.map{ |r| EquipmentReservationDecorator.new(r) }
  end

  expose(:current_user) { current_user }

  expose(:is_admin?) { current_user.try(:admin) }

  expose(:in_studio?) do
    (cookies[:studio].present? && cookies[:studio] == REDIS.get("longjohn:studio")) || is_admin?
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def requires_login
    redirect_to log_in_path unless current_user
  end

  def requires_admin
    redirect_to root_path unless current_user.try(:admin)
  end

  def requires_studio
    redirect_to root_path unless in_studio?
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end

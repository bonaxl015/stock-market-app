class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(_resource)
    current_user.user_type == 'Admin' ? rails_admin_path : stocks_market_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username user_type])
  end

  rescue_from CanCan::AccessDenied do |e|
    redirect_to main_app.stocks_market_path, alert: e.message
  end
end

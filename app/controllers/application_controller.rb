class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def after_sign_in_path_for(_resource)
    stocks_market_path
  end

  rescue_from CanCan::AccessDenied do |e|
    redirect_to main_app.stocks_market_path, alert: e.message
  end
end

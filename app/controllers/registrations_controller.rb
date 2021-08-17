class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(_resource)
    current_user.user_type == 'Admin' ? rails_admin_path : stocks_market_path
  end
end

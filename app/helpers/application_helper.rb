module ApplicationHelper
  def devise_controllers?(current_controller)
    %w[sessions registrations passwords].any? { |controller| controller.include? current_controller }
  end

  def update_user_status(email)
    user_update = User.find_by(email: email)
    user_update.update(approved: true)
  end
end

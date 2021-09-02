module ApplicationHelper
  def devise_controllers?(current_controller)
    %w[sessions registrations passwords].any? { |controller| controller.include? current_controller }
  end

  def update_user_status(email)
    user = User.find_by(email: email)
    user.update(approved: true)
  end
end

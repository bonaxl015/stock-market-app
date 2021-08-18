module ApplicationHelper
  def devise_controllers?(current_controller)
    %w[sessions registrations passwords].any? { |controller| controller.include? current_controller }
  end
end

module ApplicationHelper

  def has_devise_controllers(current_controller)
    ['sessions', 'registrations', 'passwords'].any? { |controller| controller.include? current_controller }
  end
end

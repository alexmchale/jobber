module ApplicationHelper

  def link_to_dashboard
    link_to("Back to Dashboard", dashboard_path) if current_user
  end

end

module ApplicationHelper

  def link_to_dashboard
    link_to(t("goto.dashboard"), dashboard_path) if current_user
  end

end

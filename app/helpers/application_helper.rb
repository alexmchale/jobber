module ApplicationHelper

  def js_anchor(label, id, options = {})
    options.merge! :id => id

    link_to label, "javascript:void(0)", options
  end

  def link_to_dashboard
    link_to(t("goto.dashboard"), dashboard_path) if current_user
  end

  def separator(n = 1)
    raw '<div class="separator">&nbsp;</div>' * n.to_i
  end

end

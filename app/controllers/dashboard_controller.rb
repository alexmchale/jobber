class DashboardController < ApplicationController

  before_filter :redirect_to_root, :unless => :signed_in?

  def index
  end

end

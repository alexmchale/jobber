ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'clearance/shoulda_macros'

class ActiveSupport::TestCase

  def sign_in_as_valid_user
    @user ||= Factory(:email_confirmed_user)
    sign_in_as @user
  end

end

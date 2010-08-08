ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'clearance/shoulda_macros'

class ActiveSupport::TestCase
end

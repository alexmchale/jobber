ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'clearance/shoulda_macros'

class ActiveSupport::TestCase

  setup :clear_redis

  def clear_redis
    $redis.flushdb
  end

end

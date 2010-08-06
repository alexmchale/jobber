require 'test_helper'

class InterviewTest < ActiveSupport::TestCase

  should have_one :candidate
  should validate_presence_of :starts_at

end

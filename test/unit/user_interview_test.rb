require 'test_helper'

class UserInterviewTest < ActiveSupport::TestCase

  should belong_to :user
  should belong_to :interview

end

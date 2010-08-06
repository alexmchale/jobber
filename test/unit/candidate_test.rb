require 'test_helper'

class CandidateTest < ActiveSupport::TestCase

  should validate_presence_of :name
  should validate_presence_of :email

end

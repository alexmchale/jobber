require 'test_helper'

class CandidateTest < ActiveSupport::TestCase

  should_validate_presence_of :name, :email

end

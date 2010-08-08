require 'test_helper'

class TemplateTest < ActiveSupport::TestCase

  should belong_to :user
  should validate_presence_of :name

end

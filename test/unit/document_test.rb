require 'test_helper'

class DocumentTest < ActiveSupport::TestCase

  should belong_to :interview
  should validate_presence_of :content

end

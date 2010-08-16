require 'test_helper'

class ChatMessageTest < ActiveSupport::TestCase

  should have_db_column :interview_id
  should have_db_column :user_id
  should have_db_column :message

  should belong_to :interview
  should belong_to :user
  should validate_presence_of :message

  should allow_value("public").for(:channel)
  should allow_value("private").for(:channel)
  should_not allow_value(nil).for(:channel)
  should_not allow_value("quantum").for(:channel)

end

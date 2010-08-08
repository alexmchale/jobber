class AddUserIndexToUserInterviews < ActiveRecord::Migration
  def self.up
    add_index :user_interviews, :user_id
    add_index :user_interviews, :interview_id
  end

  def self.down
    remove_index :user_interviews, :user_id
    remove_index :user_interviews, :interview_id
  end
end

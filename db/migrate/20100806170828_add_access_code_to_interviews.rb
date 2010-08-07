class AddAccessCodeToInterviews < ActiveRecord::Migration
  def self.up
    add_column :interviews, :access_code, :string
  end

  def self.down
    remove_column :interviews, :access_code
  end
end

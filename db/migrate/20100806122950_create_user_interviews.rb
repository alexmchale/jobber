class CreateUserInterviews < ActiveRecord::Migration
  def self.up
    create_table :user_interviews do |t|
      t.references :user
      t.references :interview

      t.timestamps
    end
  end

  def self.down
    drop_table :user_interviews
  end
end

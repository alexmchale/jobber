class AddStartedAtToInterview < ActiveRecord::Migration

  def self.up
    add_column :interviews, :started_at, :datetime
  end

  def self.down
    remove_column :interviews, :started_at
  end

end

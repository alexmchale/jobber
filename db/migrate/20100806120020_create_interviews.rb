class CreateInterviews < ActiveRecord::Migration
  def self.up
    create_table :interviews do |t|
      t.references :candidate
      t.datetime :starts_at

      t.timestamps
    end

    add_column :candidates, :interview_id, :integer
  end

  def self.down
    drop_table :interviews
    remove_column :candidates, :interview_id
  end
end

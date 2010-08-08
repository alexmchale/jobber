class CreateDocuments < ActiveRecord::Migration
  def self.up
    create_table :documents do |t|
      t.references :interview
      t.text :content

      t.timestamps
    end

    add_index :documents, :interview_id
  end

  def self.down
    remove_index :documents, :interview_id

    drop_table :documents
  end
end
